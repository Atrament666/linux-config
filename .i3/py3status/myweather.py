import requests
import json
import logging

logging.basicConfig(level=logging.NOTSET)
log = logging.getLogger("myweather")


class Py3status:

    weather_api_url = "http://api.openweathermap.org/data/2.5/weather"
    geocoding_api_url = "http://api.openweathermap.org/geo/1.0/direct"
    api_key = ""
    city = ""
    unit_system = "metric"
    time_in = 3600
    format = "{main}, {temperature}"

    icons = {
        "01d": "\U0001f323",
        "02d": "\u26C5",
        "03d": "\u2601",
        "04d": "\u2601",
        "09d": "\u26c6",
        "10d": "\u26c6",
        "11d": "\u26c8",
        "13d": "\u2744",
        "50d": "\U0001F32B",
        "01n": "\u2600",
        "02n": "\u26C5",
        "03n": "\u2601",
        "04n": "\u2601",
        "09n": "\u26c6",
        "10n": "\u26c6",
        "11n": "\u26c8",
        "13n": "\u2744",
        "50n": "\U0001F32B",
    }

    temperature_units = {"default": "\u00b0K", "metric": "\u00b0C", "imperial": "\u00b0F"}

    def _get_location_coords(self, location):
        try:
            log.debug(f"Fetching {self.city}'s coords")
            response = requests.get(
                self.geocoding_api_url + "?q=" + self.city + "&appid=" + self.api_key
            )
            json_str = response.content.decode("utf-8")
            log.debug(json_str)
            data = json.loads(json_str)
            if data[0]:
                log.debug(f"latitude: {data[0]['lat']}")
                log.debug(f"longitude: {data[0]['lon']}")
                return {
                    "name": data[0]["name"],
                    "lat": data[0]["lat"],
                    "lon": data[0]["lon"],
                }

        except requests.exceptions.RequestException as e:
            log.debug(e)

    def _get_current_weather(self, coords):
        try:
            log.debug(f"Fetching weather info for {coords}")
            response = requests.get(
                self.weather_api_url
                + "?lat="
                + str(coords["lat"])
                + "&lon="
                + str(coords["lon"])
                + "&units=metric"
                + "&appid="
                + self.api_key
            )
            json_str = response.content.decode("utf-8")
            data = json.loads(json_str)
            log.debug(data)
            if "weather" in data and "wind" in data and "main" in data:

                return {
                    "main": data["weather"][0]["main"],
                    "temperature": (
                        str(round(data["main"]["temp"])) + self.temperature_units[self.unit_system]
                        if self.units == "metric"
                        else "F"
                    ),
                    "feels_like": (
                        str(round(data["main"]["feels_like"])) + self.temperature_units[self.unit_system]
                        if self.units == "metric"
                        else "F"
                    ),
                    "wind_speed": data["wind"]["speed"],
                    "wind_gust": data["wind"]["gust"],
                    "icon": data["weather"][0]["icon"],
                }
            else:
                return {"main": "Něco se nepovedlo"}
        except requests.exceptions.RequestException as e:
            log.debug(e)

    def get_result(self):
        if self.city:
            coords = self._get_location_coords(self.city)
            if coords:
                weather = self._get_current_weather(coords)
                if weather:
                    full_text = self.format.format(
                        main=weather["main"],
                        temperature=weather["temperature"],
                    )
                    return {
                        "full_text": full_text,
                        "cached_until": self.py3.time_in(self.time_in),
                    }
            else:
                return {
                    "full_text": f"No coords found for {self.city}",
                    "cached_until": self.py3.time_in(self.time_in),
                }

        else:
            return {
                "full_text": "No city specified",
                "cached_until": self.py3.time_in(self.time_in),
            }


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test

    config = {
        "api_key": "66eb01b63c27840ab769e63036731384",
        "city": "Plymouth,GB",
        "units": "metric",
    }

    module_test(Py3status, config=config)
