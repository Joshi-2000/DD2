import React from "react";
import SearchBar from "./SearchBar";
import PieGraph from "./PieGraph";
import LineGraph from "./LineGraph";


import './App.css'

function StartPage() {
 

  return (
    <div style={{backgroundColor: '#19323E', margin: '0px'}}>
      <div className="mainHeadline">Crypto.DD2</div>
      <div style={{height: "90px", width:"100%", backgroundColor: '#19323E'}}>
          <SearchBar/>
      </div>
      <div style={{display: "flex", flexWrap:"wrap"}}>
        <div style={{border: "3px solid #1C4356", borderRadius: "9px", width:"43%", marginLeft:"3%", marginRight: "1%", marginTop: "2vh", marginBottom: "2vh", padding:"1%"}}>
          <PieGraph/>
        </div>
        <div style={{border: "3px solid #1C4356", borderRadius: "9px", width:"43%", marginLeft:"1%", marginTop: "2vh", padding:"1%", marginBottom: "2vh",}}>
          <LineGraph reqPath="/OverallMarketCap" displayStr="Overall Market Cap"/>
        </div>
        <div style={{width: "43%", marginLeft: "3%", marginRight: "1%",  padding: "1%",border: "3px solid #1C4356", borderRadius: "9px"}}>
          <LineGraph reqPath="/BestCoin" interval="day" varType="price" title="b"/>
        </div>
        <div style={{width: "43%", marginLeft: "1%", marginRight: "3%",  padding: "1%",border: "3px solid #1C4356", borderRadius: "9px"}}>
          <LineGraph reqPath="/WorstCoin" interval="day" varType="price" title="w"/>
        </div>
      </div>
    </div>
  );
 }

export default StartPage;

