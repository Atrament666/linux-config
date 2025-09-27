class Py3status:

    def hello_world(self):
        return {
                'full_text':'Hello world',
                'cached_until': self.py3.CACHE_FOREVER
        }
if __name__ == "__main__":
    """
    Run module in test mode.
    """
    from py3status.module_test import module_test
    module_test(Py3status)        
