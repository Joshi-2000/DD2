import React from 'react'
import { useEffect, useState} from 'react';

export default function InfoBox(props) {
    const [infoData, setinfoData] = useState(null);

    useEffect(() => {
        const fetchdData = async () => {
            const result = await fetch("http://localhost:8000/Overview/?abbr=" + props.coin);
            const jsonResult = await result.json();
            if (jsonResult.detail === "Abbreviation not found"){
                setinfoData("Error");
            }
            else{
                if (jsonResult.max_supply == null){
                jsonResult.max_supply = "infinite"
                }
                setinfoData(jsonResult);
            }
        }
        fetchdData();
        }, [])

    if (infoData == undefined) return <div>
        <h1> Please wait some time.... </h1> </div> ;
    if (infoData === "Error") return <div>
        <h1> Cryptocurrency not found </h1> </div> ;
    return (
        <>
        <p className='headline-center'> General information </p>
            <ul className='GenList'>
                <li><span>Name:</span> <span className='GenUlRight'>{infoData.name}</span></li>
                <li><span>Release:</span> <span className='GenUlRight'>{infoData.date_added}</span></li>
                <li><span>Maximum Supply:</span> <span className='GenUlRight'>{infoData.max_supply}</span></li>
                <li><span>Price:</span> <span className='GenUlRight'> {infoData.price + " €"}</span></li>
                <li><span>24h Volume:</span> <span className='GenUlRight'>{infoData.volume_24h}</span></li>
                <li><span>Market Cap Dominance:</span> <span className='GenUlRight'>{infoData.market_cap_dominance + " %"}</span></li>
                <li><span>Circulating Supply:</span> <span className='GenUlRight'>{infoData.circulating_supply}</span></li>

            </ul>
        </> 
    )
}
