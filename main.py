from fastapi import FastAPI, HTTPException
import psycopg
from psycopg_pool import ConnectionPool
import json
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = [
    "http://localhost:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


connPool = ConnectionPool(conninfo= "host=91.18.177.109 dbname=Crypto user=pgsql password=example")

@app.get("/Overview/")
def Overview(abbr: str = "all"):
    conn = connPool.getconn()
    cur = conn.cursor()
    if abbr == "all": 
        cur.execute("SELECT * FROM Cryptocurrency")
        top_100 = cur.fetchall()
        coin_dict= {}
        for coin in top_100:
            coin_dict[coin[1]]={"coin_id":coin[5], "name":coin[0], "date_added":coin[2].isoformat(), "tags":[coin[3]], "max_supply":[coin[4]]}
        connPool.putconn(conn)
        return coin_dict
    else:
        cur.execute("SELECT * FROM Cryptocurrency WHERE symbol = %s", (abbr,))
        coinData = cur.fetchall()[0]
        connPool.putconn(conn)
        if len(coinData) == 0:
            raise HTTPException(status_code=404, detail="Abbreviation not found")
        return  {"coin_id":coinData[5], "name":coinData[0], "date_added":coinData[2].isoformat(), "tags":[coinData[3]], "max_supply":[coinData[4]]}
    
@app.get("/names")
def Names():
    coin_dict = Overview()
    names_dict = {}
    for coin in coin_dict.keys():
        names_dict[coin]=coin_dict[coin]["name"]
    return names_dict


#last_updated, price, volume_24h, market_cap_dominance, circulating_supply

@app.get("/Coin/{abbr}")
def Coin(abbr: str):
    conn = connPool.getconn()
    cur = conn.cursor()
    cur.execute("SELECT crypto_tsd.last_updated, crypto_tsd.price, crypto_tsd.volume_24h, crypto_tsd.market_cap_dominance, crypto_tsd.circulating_supply FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id WHERE Cryptocurrency.symbol = %s", (abbr,))
    coinData = cur.fetchall()
    connPool.putconn(conn)
    if len(coinData) == 0:
        raise HTTPException(status_code=404, detail="Abbreviation not found")
    coin_dict = {"last_updated":[], "price":[], "volume_24h":[], "market_cap_dominance":[], "circulating_supply":[]}
    for data in coinData:
        coin_dict["last_updated"].append(data[0].isoformat())
        coin_dict["price"].append(data[1])
        coin_dict["volume_24h"].append(data[2])
        coin_dict["market_cap_dominance"].append(data[3])
        coin_dict["circulating_supply"].append(data[4])
    return coin_dict

@app.get("/MarketCap")
def MarketCap():
    conn = connPool.getconn()
    cur = conn.cursor()
    cur.execute("SELECT cryptocurrency.symbol, crypto_tsd.market_cap_dominance FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id ORDER BY crypto_tsd.last_updated DESC LIMIT 100")
    capData=cur.fetchall()
    connPool.putconn(conn)
    sorted_by_second = sorted(capData, key=lambda tup: tup[1], reverse=True)
    capData = sorted_by_second[:20]
    cap_list=[]
    cap_count = 0
    for cap in capData:
        cap_list.append({"name": cap[0], "value":cap[1]})
        cap_count += cap[1]
    cap_list.append({"name":"Others", "value": round(100-cap_count,4)})
    return cap_list