import json
from datetime import datetime, date


class Py3status:
    format = 'Dnes má svátek: {name}'
    cache_timeout = 3600
    url = ''

    def svatky(self):
        def isCzechMothersDay():
            today = date.today()
            d = date(today.year, 5, 1)
            mothers_day = date(today.year, 5, 15 - d.weekday() - 1)
            #mothers_day = date(today.year, 5, 12)
            return today == mothers_day
 

        try:
            with open('/usr/share/svatky.json') as json_data:
                events = json.load(json_data)["VCALENDAR"][0]["VEVENT"]
                for event in events:
                    event_day = datetime.strptime(
                        event["DTSTART;Europe/Prague;VALUE=DATE"], '%Y%m%d').strftime('%m%d')
                    if event_day == datetime.now().strftime('%m%d'):
                        self.url = event["URL"]
                        name = event["DESCRIPTION"] + ", Den matek" if isCzechMothersDay() else event["DESCRIPTION"]

            return {
                'full_text': self.py3.safe_format(self.format, {'name': name}),
                'cached_until': self.py3.time_in(self.cache_timeout),
                'url': self.url
            }
        except Exception as ex:
            print(ex)
            return { 'full_text': "Error", 'cached_until': self.py3.time_in(self.cache_timeout), 'url': self.url}


if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test
    module_test(Py3status)
