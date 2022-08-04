import {useEffect, useState, button} from 'react';
import styled from "styled-components";


import{
    AreaChart,
    Area,
    ResponsiveContainer,
    Tooltip,
    XAxis,
    YAxis,
    CartesianGrid,
  } from 'recharts';

export default function LineGraph() {
    const [data, setData] = useState(null);
    const [dData, setdData] = useState(null);
    const [wData, setwData] = useState(null);
    const [mData, setmData] = useState(null);
    const [yData, setyData] = useState(null);
    

    useEffect(() => {
        const fetchdData = async () => {
            const result = await fetch("http://localhost:8000/Coin/d/BTC");
            const jsonResult = await result.json();
            setdData(jsonResult);
        }
        fetchdData();
        const fetchwData = async () => {
            const result = await fetch("http://localhost:8000/Coin/w/BTC");
            const jsonResult = await result.json();
            setwData(jsonResult);
            setData(jsonResult);
        }
        fetchwData();
        const fetchmData = async () => {
            const result = await fetch("http://localhost:8000/Coin/m/BTC");
            const jsonResult = await result.json();
            setmData(jsonResult);
        }
        fetchmData();
        const fetchyData = async () => {
            const result = await fetch("http://localhost:8000/Coin/y/BTC");
            const jsonResult = await result.json();
            setyData(jsonResult);
        }
        fetchyData();
        
    }, [])
    function changeTo(res){
      if ( res == "d"){
        setData(dData)
      }
      if ( res == "w"){
        setData(wData)
      }
      if ( res == "m"){
        setData(mData)
      }
      if ( res == "y"){
        setData(yData)
      }
    }
    return (
        <div width="100%">
        <div display="flex" justify-content="flex-end" >
        <button margin ="10px" onClick={() => changeTo("d")}>Day</button>
        <button onClick={() => changeTo("w")}>Week</button>
        <button onClick={() => changeTo("m")}>Month</button>
        <button onClick={() => changeTo("y")}>Year</button>
        </div>
        <ResponsiveContainer width="100%" height={400}>
            <AreaChart data = {data}>
                <defs>
                    <linearGradient id="color" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="0%" stopColor='#4F465E' stopOpacity={0.9}></stop>
                        <stop offset="75%" stopColor='#4F465E' stopOpacity={0.25}></stop>
                    </linearGradient>
                </defs>
                
                <Area dataKey= "price" stroke="#4F465E" fill='url(#color)' />
                <XAxis dataKey="last_updated" />

                <YAxis dataKey= "price" domain={['auto', 'auto']} tickCount= {8} tickFormatter={(number) => `${number}€`}/>


                <Tooltip/>
                <CartesianGrid opacity={0.9}/>
            </AreaChart>
        </ResponsiveContainer>
        </div>
    )
   
} 