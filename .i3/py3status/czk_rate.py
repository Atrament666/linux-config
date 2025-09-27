# -*- coding: utf-8 -*-
"""
Displays CZK exchange rate for specified code using https://data.kurzy.cz site.

Configuration parameters:
    cache_timeout: Refresh rate in seconds (default 600)
    code: rate code  (GBP, USD...)

@author Atrament
@license BSD

SAMPLE OUTPUT
{'full_text': u'$1.061 \xa30.884 \xa5121.538'}
"""
import requests
import json
import logging


class Py3status:
    cache_timeout = 600
    url = "https://data.kurzy.cz/json/meny/b[6]cb[vypsat].js"
    code = ""

    def post_config_hook(self):
        self.request_timeout = 20

    def __get_rate(self):
        try:
            logging.info("Getting response")
            response = requests.get(self.url, timeout=self.request_timeout)
            logging.info(response)
            data_str = response.content.decode("utf-8")
            json_str = data_str[data_str.find("(") + 1 : data_str.rfind(")")]
            data = json.loads(json_str)
            if (
                "kurzy" in data
                and self.code in data["kurzy"]
                and "dev_stred" in data["kurzy"][self.code]
            ):
                return data["kurzy"][self.code]["dev_stred"]
            else:
                raise ValueError("Invalid data format")

        except requests.exceptions.RequestException as e:
            logging.error(f"Request error: {e}")
            return None
        except ValueError as e:
            logging.error(f"Data format error: {e}")
            return None

    def rates(self):
        if self.code:
            rate = self.__get_rate()
            if rate is not None:
                return {
                    "full_text": f"{self.code}: {rate:.2f}",
                    "cached_until": self.py3.time_in(self.cache_timeout),
                }
            else:
                return {"full_text": "Read error", "cached_until": self.py3.time_in(10)}
        else:
            return {
                "full_text": "Code not specified",
                "cached_until": self.py3.CACHE_FOREVER,
            }


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test

    config = {"code": "GBP"}

    module_test(Py3status, config=config)
