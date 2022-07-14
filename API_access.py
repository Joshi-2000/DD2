from requests import Request, Session
from requests.exceptions import ConnectionError, Timeout, TooManyRedirects
import json
import psycopg

url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
parameters = {
  'start':'1',
  'limit':'200',
  'convert':'USD'
}
headers = {
  'Accepts': 'application/json',
  'X-CMC_PRO_API_KEY': '47057497-89d3-4ed9-8fb2-996148142a8a',
}

session = Session()
session.headers.update(headers)

try:
  response = session.get(url, params=parameters)
  data = json.loads(response.text)
except (ConnectionError, Timeout, TooManyRedirects) as e:
  pass


conn = psycopg.connect(
    host="localhost",
    dbname="Crypto",
    user="pgsql",
    password="example")

cur = conn.cursor()

for coin in data["data"][:100]:
  conn.execute("INSERT INTO Cryptocurrency (name,symbol,date_added, tags, max_supply) VALUES (%s,%s,%s,%s,%s)",
      (coin["name"],
      coin["symbol"],
      coin["date_added"],
      json.dumps(coin["tags"]),
      coin["max_supply"]
      )
  
  )
conn.commit()

