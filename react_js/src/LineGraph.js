import {useEffect, useState} from 'react';
import styled from 'styled-components';
import './App.css'

import{
    AreaChart,
    Area,
    ResponsiveContainer,
    Tooltip,
    XAxis,
    YAxis,
    CartesianGrid,
  } from 'recharts';

const Button = styled.button`
  background-color: black;
  color: white;
  font-size: 16px;
  padding: 6px 25px;
  border-radius: 5px;
  margin: 0px 5px 5px 0px;
  cursor: pointer;
  &:disabled {
    color: grey;
    opacity: 0.7;
    cursor: default;
  }
`;

const ButtonToggle = styled(Button)`
  opacity: 0.7;
  ${({ active }) =>
    active &&
    `
    opacity: 1; 
  `}
`;

const ButtonGroup = styled.div`
  display: flex;
  flex-wrap: wrap;
  justify-content: flex-end;
`;

const types = ['Day', 'Week', 'Month', 'Year'];

const LineGraph = (props) => {
    const [data, setData] = useState(null);
    const [dData, setdData] = useState(null);
    const [wData, setwData] = useState(null);
    const [mData, setmData] = useState(null);
    const [yData, setyData] = useState(null);

    
    const [active, setActive] = useState(types[1]);

    useEffect(() => {
        const fetchdData = async () => {
            const result = await fetch("http://localhost:8000/Coin/d/" + props.Coin);
            const jsonResult = await result.json();
            setdData(jsonResult);
        }
        fetchdData();
        const fetchwData = async () => {
            const result = await fetch("http://localhost:8000/Coin/w/" + props.Coin);
            const jsonResult = await result.json();
            setwData(jsonResult);
            setData(jsonResult);
        }
        fetchwData();
        const fetchmData = async () => {
            const result = await fetch("http://localhost:8000/Coin/m/"  + props.Coin);
            const jsonResult = await result.json();
            setmData(jsonResult);
        }
        fetchmData();
        const fetchyData = async () => {
            const result = await fetch("http://localhost:8000/Coin/y/" + props.Coin);
            const jsonResult = await result.json();
            setyData(jsonResult);
        }
        fetchyData();
        
    }, []);
    
    function changeTo(res){
      if ( res === "Day"){
        setData(dData)
      }
      if ( res === "Week"){
        setData(wData)
      }
      if ( res === "Month"){
        setData(mData)
      }
      if ( res === "Year"){
        setData(yData)
      }
    }
    if (data == undefined) return <div>
            <h1> Please wait some time.... </h1> </div> ;
    return (
        <div >
        <ButtonGroup>
          <p class="headline">{props.Coin}</p>
          {types.map(type => (
            <ButtonToggle
              key={type}
              active={active === type}
              onClick={function(event){setActive(type);
                                      changeTo(type);}}
            >
            {type}
          </ButtonToggle>
          ))}
        </ButtonGroup>


        <ResponsiveContainer height={400} >
            <AreaChart data = {data.data}>
                <defs>
                    <linearGradient id="color" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="0%" stopColor='#00858e' stopOpacity={0.9}></stop>
                        <stop offset="75%" stopColor='#225769' stopOpacity={0.4}></stop>
                    </linearGradient>
                </defs>
                
                <Area dataKey= "price" stroke="#00b497" fill='url(#color)' />
                <XAxis minTickGap={20} dataKey="last_updated" tick={{fill: '#94A6A6', fontFamily: 'sans-serif'}} />

                <YAxis dataKey= "price"  tick={{fill: '#94A6A6', fontFamily: 'sans-serif'}} domain={['auto', 'auto']} tickCount= {7} tickFormatter={(number) => `${number}€`}/>


                <Tooltip/>
                <CartesianGrid opacity={0.2}/>
            </AreaChart>
        </ResponsiveContainer>
        </div>
    )
   
} 

export default LineGraph;