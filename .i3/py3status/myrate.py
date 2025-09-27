from lxml import html
import requests


page = requests.get('https://finance.idnes.cz/kurzovni-listek.aspx?typ=banky&mena=GBP')
tree = html.fromstring(page.content)

rate = tree.xpath('//th[@class="tar"]/text()')[0]

print(rate.replace(",","."))
