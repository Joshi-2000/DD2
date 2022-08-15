import React from 'react';

import { Routes, Route, useLocation } from 'react-router-dom';
import SearchBar from "./SearchBar";
import LineGraph from './LineGraph';
import InfoBox from './InfoBox';
import {useNavigate} from 'react-router-dom';
var mappingList = require("./mappingList.json");

export default function DetailPage() {
    
    const location = useLocation().pathname.slice(1).replace('%20', ' ');
    var coin;
    if(Object.keys(mappingList).includes(location)){
        coin  = mappingList[location];
    }
    else{
        coin = location.toUpperCase();
    }

    const navigate = useNavigate();
    const navigateToContacts = () => {
      navigate('/');
    };

  return (

    <div style={{backgroundColor: '#19323E', margin: '0px'}}>
        <div className="mainHeadline" onClick={navigateToContacts}>Crypto.DD2</div>
        <div style={{height: "90px", width:"100%", backgroundColor: '#19323E' }}>
          <SearchBar/>
        </div>
        <div style={{display: "flex", flexWrap:"wrap"}}>
            <div style={{border: "3px solid #1C4356", borderRadius: "9px", width:"59%", marginLeft:"3%", marginRight: "1%", marginTop: "2vh", padding:"1%", marginBottom: "2vh",}}>
            <LineGraph reqPath= {"/Coin/" + coin} interval="week" varType="price"/>
            </div>
            <div style={{border: "3px solid #1C4356", borderRadius: "9px", width:"27%", marginLeft:"1%", marginTop: "2vh", padding:"1%", marginBottom: "2vh",}}>
              <InfoBox coin={coin}></InfoBox>
            </div>
            <div style={{border: "3px solid #1C4356", borderRadius: "9px", width:"43%", marginLeft:"3%", marginRight: "1%", marginTop: "2vh", padding:"1%", marginBottom: "2vh",}}>
            <LineGraph reqPath= {"/Coin/" + coin} interval="week" varType="volume_24h"/>
            </div>
            <div style={{border: "3px solid #1C4356", borderRadius: "9px", width:"43%", marginLeft:"1%", marginTop: "2vh", padding:"1%", marginBottom: "2vh",}}>
            <LineGraph reqPath= {"/Coin/" + coin} interval="week" varType="market_cap_dominance"/>
            </div>
        </div>
    </div>
    

  )
}
