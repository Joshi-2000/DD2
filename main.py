from fastapi import FastAPI, HTTPException
import psycopg
from psycopg_pool import ConnectionPool
import json
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = [
    "http://localhost:3000",
    "http://localhost:3000/"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


connPool = ConnectionPool(conninfo= "host=87.146.94.122 dbname=Crypto user=pgsql password=example")

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
    coin_dict = Overview("all")
    names_dict = {}
    for coin in coin_dict.keys():
        names_dict[coin]=coin_dict[coin]["name"]
    return names_dict

@app.get("/datanames")
def Datanames():
    coin_dict = Overview("all")
    names = []
    for coin in coin_dict.keys():
        names.append({"fullname": coin_dict[coin]["name"]})
        names.append({"abbr":coin})
    return names


#last_updated, price, volume_24h, market_cap_dominance, circulating_supply

@app.get("/Coin/{interval}/{abbr}")
def Coin(abbr: str, interval: str):
    conn = connPool.getconn()
    cur = conn.cursor()
    cur.execute("SELECT name FROM cryptocurrency WHERE symbol = %s ", (abbr,))
    name = cur.fetchall()[0][0]
    if interval == "d":
        cur.execute("SELECT crypto_tsd.last_updated, crypto_tsd.price, crypto_tsd.volume_24h, crypto_tsd.market_cap_dominance, crypto_tsd.circulating_supply FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id WHERE Cryptocurrency.symbol = %s AND crypto_tsd.last_updated >= NOW() - '1 day'::INTERVAL ORDER BY crypto_tsd.last_updated", (abbr,))
    elif interval == "w":
        cur.execute("SELECT DATE_TRUNC('hour', crypto_tsd.last_updated) AS date, AVG(crypto_tsd.price) as avg_price, AVG(crypto_tsd.volume_24h) AS avg_volume_24h, AVG(crypto_tsd.market_cap_dominance) AS avg_market_cap_dominance, AVG(crypto_tsd.circulating_supply) AS avg_circulating_supply FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id WHERE Cryptocurrency.symbol = %s AND crypto_tsd.last_updated >= NOW() - '7 day'::INTERVAL  GROUP BY DATE_TRUNC('hour', crypto_tsd.last_updated) ORDER BY date ", (abbr,))
    elif interval == "m":
        cur.execute("SELECT DATE_TRUNC('hour', crypto_tsd.last_updated) AS date, AVG(crypto_tsd.price) as avg_price, AVG(crypto_tsd.volume_24h) AS avg_volume_24h, AVG(crypto_tsd.market_cap_dominance) AS avg_market_cap_dominance, AVG(crypto_tsd.circulating_supply) AS avg_circulating_supply FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id WHERE Cryptocurrency.symbol = %s AND crypto_tsd.last_updated >= NOW() - '30 day'::INTERVAL  GROUP BY DATE_TRUNC('hour', crypto_tsd.last_updated) ORDER BY date ", (abbr,))
    elif interval == "y":
        cur.execute("SELECT DATE_TRUNC('day', crypto_tsd.last_updated) AS date, AVG(crypto_tsd.price) as avg_price, AVG(crypto_tsd.volume_24h) AS avg_volume_24h, AVG(crypto_tsd.market_cap_dominance) AS avg_market_cap_dominance, AVG(crypto_tsd.circulating_supply) AS avg_circulating_supply FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id WHERE Cryptocurrency.symbol = %s AND crypto_tsd.last_updated >= NOW() - '365 day'::INTERVAL GROUP BY DATE_TRUNC('day', crypto_tsd.last_updated) ORDER BY date ", (abbr,))
    else:
        connPool.putconn(conn)
        raise HTTPException(status_code=404, detail="given interval not found")
    coinData = cur.fetchall()
    connPool.putconn(conn)
    if len(coinData) == 0:
        raise HTTPException(status_code=404, detail="Abbreviation not found")
    coin_list = []
    if interval == "y":
        for data in coinData:
            coin_list.append({"last_updated": data[0].strftime("%d.%m.%Y"), "price":data[1], "volume_24h":data[2], "market_cap_dominance":data[3], "circulating_supply":data[4]})
    if interval == "m" or interval == "w":
        for data in coinData:
            coin_list.append({"last_updated": data[0].strftime("%d.%m %H:%M"), "price":data[1], "volume_24h":data[2], "market_cap_dominance":data[3], "circulating_supply":data[4]})
    if interval == "d":
        for data in coinData:
            coin_list.append({"last_updated": data[0].strftime("%d.%m %H:%M"), "price":data[1], "volume_24h":data[2], "market_cap_dominance":data[3], "circulating_supply":data[4]})
    return {"overview": {"symbol": abbr, "name": name} ,"data":coin_list}

@app.get("/MarketCap")
def MarketCap():
    conn = connPool.getconn()
    cur = conn.cursor()
    cur.execute("SELECT cryptocurrency.symbol, crypto_tsd.market_cap_dominance FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id ORDER BY crypto_tsd.last_updated DESC LIMIT 100")
    capData=cur.fetchall()
    connPool.putconn(conn)
    sorted_by_second = sorted(capData, key=lambda tup: tup[1], reverse=True)
    capData = sorted_by_second[:11]
    cap_list=[]
    cap_count = 0
    for cap in capData:
        cap_list.append({"name": cap[0], "value":cap[1]})
        cap_count += cap[1]
    cap_list.append({"name":"Others", "value": round(100-cap_count,4)})
    return cap_list

@app.get("/OverallMarketCap")
def OverallMarketCap():
    conn = connPool.getconn()
    cur = conn.cursor()
    cur.execute("WITH Dist AS (SELECT cryptocurrency.symbol AS symbol, DATE_TRUNC('day', crypto_tsd.last_updated) AS date, AVG(crypto_tsd.circulating_supply*crypto_tsd.price) AS market_cap FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id GROUP BY symbol, date) SELECT date, SUM(market_cap) FROM Dist GROUP BY date ORDER BY date")
    capData=cur.fetchall()
    connPool.putconn(conn)
    cap_list = []
    for cap in capData:
        cap_list.append({"last_updated":cap[0].strftime("%d.%m.%Y"), "market_cap":round(cap[1],-9)/(1*10**9)})
    return cap_list

@app.get("/BestCoin")
def BestCoin():
    conn = connPool.getconn()
    cur = conn.cursor()
    cur.execute("SELECT cryptocurrency.symbol, crypto_tsd.price FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id ORDER BY crypto_tsd.last_updated DESC LIMIT 100")
    newData=cur.fetchall()
    sorted_new = sorted(newData, key=lambda tup: tup[0])
    cur.execute("SELECT cryptocurrency.symbol, crypto_tsd.price FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id WHERE crypto_tsd.last_updated >= NOW() - '1 day'::INTERVAL ORDER BY crypto_tsd.last_updated LIMIT 100")
    oldData=cur.fetchall()
    sorted_old = sorted(oldData, key=lambda tup: tup[0])
    connPool.putconn(conn)
    max = [0,""]
    for i in range(len(newData)):
        increase = sorted_new[i][1]/sorted_old[i][1]
        if increase > max[0]:
            max = [increase, sorted_new[i][0]]
    response = Coin(max[1], "d")
    response["overview"]["increase"] = round((max[0] -1) *100,2)
    return response

@app.get("/WorstCoin")
def WorstCoin():
    conn = connPool.getconn()
    cur = conn.cursor()
    cur.execute("SELECT cryptocurrency.symbol, crypto_tsd.price, crypto_tsd.last_updated FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id ORDER BY crypto_tsd.last_updated DESC LIMIT 100")
    newData=cur.fetchall()
    sorted_new = sorted(newData, key=lambda tup: tup[0])
    cur.execute("SELECT cryptocurrency.symbol, crypto_tsd.price, crypto_tsd.last_updated FROM crypto_tsd INNER JOIN cryptocurrency ON crypto_tsd.crypto_id = Cryptocurrency.crypto_id WHERE crypto_tsd.last_updated >= NOW() - '1 day'::INTERVAL ORDER BY crypto_tsd.last_updated LIMIT 100")
    oldData=cur.fetchall()
    sorted_old = sorted(oldData, key=lambda tup: tup[0])
    connPool.putconn(conn)
    min = [2,""]
    for i in range(len(newData)):
        increase = sorted_new[i][1]/sorted_old[i][1]
        if increase < min[0]:
            min = [increase, sorted_new[i][0]]
    response = Coin(min[1], "d")
    response["overview"]["increase"] = round((min[0] -1) *100,2)
    return response

  
        