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
  margin: 8px 5px 5px 0px;
  cursor: pointer;
  align-self: flex-end;
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
  width: 100%;
`;

const types = ['Day', 'Week', 'Month', 'Year'];

const LineGraph = (props) => {
    const [data, setData] = useState(null);
    const [reData, setreData] = useState(null);

    const [varType, setVarType] = useState();
    const [active, setActive] = useState(types[1]);

    useEffect(() => {
        const fetchdData = async () => {
            const result = await fetch("http://localhost:8000" + props.reqPath);
            const jsonResult = await result.json();
            setVarType(props.varType);
            if (Object.keys(jsonResult.data).length == 4){
              
              if(props.interval === "day"){
                setData(jsonResult.data.day);
                setActive(types[0]);
              }
              if(props.interval === "week"){
                setData(jsonResult.data.week);
                
              }
              if(props.interval === "month"){
                setData(jsonResult.data.month);
                setActive(types[2]);
              } 

            }
            else{
              setData(jsonResult.data.tsd);
            }
            setreData(jsonResult);
        };
        fetchdData();
        
    }, []);
    
    function changeTo(res){
      if ( res === "Day"){
        setData(reData.data.day)
      }
      if ( res === "Week"){
        setData(reData.data.week)
      }
      if ( res === "Month"){
        setData(reData.data.month)
      }
      if ( res === "Year"){
        setData(reData.data.year)
      }
    }
    if (data == undefined) return <div>
            <h1> Please wait some time.... </h1> </div> ;
    if(Object.keys(reData.data).length == 4){
    return (
        <div >
        <ButtonGroup>
          <div className='headlineBox'>
            <p className='varType'> {(props.title === "b" ? "Best 24h": props.title === "w" ? "Worst 24h": varType === "price" ? "price" : varType === "volume_24h" ? "24h volume": "market cap dominance")}</p>
            <p className="headline">{reData.overview.displayed_str + " "}<span className="varType">{(props.title === "b" ? reData.overview.increase + "%" : props.title === "w" ? reData.overview.increase + "%": "")}</span></p>
          </div>
          <div style={{marginLeft: "auto"}}>
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
          </div>
        </ButtonGroup>


        <ResponsiveContainer height={400} >
            <AreaChart data = {data}>
                <defs>
                    <linearGradient id="color" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="0%" stopColor='#00858e' stopOpacity={0.9}></stop>
                        <stop offset="75%" stopColor='#225769' stopOpacity={0.4}></stop>
                    </linearGradient>
                </defs>
                
                <Area dataKey= {varType} stroke="#00b497" fill='url(#color)' />
                <XAxis minTickGap={20} dataKey="last_updated" tick={{fill: '#94A6A6', fontFamily: 'sans-serif'}} />

                <YAxis dataKey= {varType}  width={100} tick={{fill: '#94A6A6', fontFamily: 'sans-serif'}} domain={['auto', 'auto']} tickCount= {7} tickFormatter={(number) => `${(number + (varType === "price" ? "€" : varType === "volume_24h" ? "m": "%"))}`}/>


                <Tooltip/>
                <CartesianGrid opacity={0.2}/>
            </AreaChart>
        </ResponsiveContainer>
        </div>
    )
    }
    else{
      return (
        <div >
        <ButtonGroup>
          <p className="headline">{reData.overview.displayed_str}</p>
        </ButtonGroup>

        <ResponsiveContainer height={400} >
            <AreaChart data = {data}>
                <defs>
                    <linearGradient id="color" x1="0" y1="0" x2="0" y2="1">
                        <stop offset="0%" stopColor='#00858e' stopOpacity={0.9}></stop>
                        <stop offset="75%" stopColor='#225769' stopOpacity={0.4}></stop>
                    </linearGradient>
                </defs>
                
                <Area dataKey= "value" stroke="#00b497" fill='url(#color)' />
                <XAxis minTickGap={20} dataKey="last_updated" tick={{fill: '#94A6A6', fontFamily: 'sans-serif'}} />

                <YAxis dataKey= "value" width={65} tick={{fill: '#94A6A6', fontFamily: 'sans-serif'}} domain={['auto', 'auto']} tickCount= {7} tickFormatter={(number) => `${number + reData.overview.unit}`}/>


                <Tooltip/>
                <CartesianGrid opacity={0.2}/>
            </AreaChart>
        </ResponsiveContainer>
        </div>
    )
    }
   
} 

export default LineGraph;