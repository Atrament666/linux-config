class Py3status:

    
    format = '{typ}'
    cache_timeout = 3600
    url = ''

    def bin(self):
        import datetime
        today = datetime.date.today()
        week_number = today.isocalendar()[1]

        if week_number % 2 != 0:  
            return {
                    'full_text': self.py3.safe_format(self.format, {'typ': '♻'}), 

                    'cached_until': self.py3.time_in(self.cache_timeout),
                    'url' : self.url
                    }
        else:
            return {
                    'full_text': self.py3.safe_format(self.format, {'typ': ''}),
                    'cached_until': self.py3.time_in(self.cache_timeout),
                    'url' : self.url
                    }

if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test
    module_test(Py3status)        
