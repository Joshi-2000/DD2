from requests.exceptions import ConnectionError, Timeout, TooManyRedirects
import requests
import psycopg
import json
import time

time.sleep(10)

conn = psycopg.connect(
    host="db",
    dbname="crypto",
    user="crypto",
    password="example")

cur = conn.cursor()

url = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'
parameters = {
  'start':'1',
  'limit':'200',
  'convert':'EUR'
}
headers = {
  'Accepts': 'application/json',
  'X-CMC_PRO_API_KEY': '47057497-89d3-4ed9-8fb2-996148142a8a',
}

cur.execute("SELECT crypto_id, name FROM cryptocurrency")
top_100 = cur.fetchall()

name_id_dict = {}
for coin in top_100:
    name_id_dict[coin[1]]=coin[0]
conn.commit()



print("Connection finished")

while True:
    try:
        resp = requests.get(url,params=parameters, headers=headers)
        resp_json = json.loads(resp.text)  
        resp_json = resp_json["data"]
        for coin in resp_json:
            if coin["name"] in name_id_dict.keys():
                cur.execute("INSERT INTO crypto_tsd (crypto_id, last_updated, price, volume_24h, market_cap_dominance, circulating_supply)  VALUES (%s,%s,%s,%s,%s,%s)", 
                (name_id_dict[coin["name"]],
                coin["last_updated"],
                coin["quote"]["EUR"]["price"],
                coin["quote"]["EUR"]["volume_24h"],
                coin["quote"]["EUR"]["market_cap_dominance"],
                coin["circulating_supply"]    
                ))
        conn.commit()
        
    except (ConnectionError, Timeout, TooManyRedirects) as e:
        pass
    time.sleep(300)
