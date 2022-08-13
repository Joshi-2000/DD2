import React from "react";
import PieGraph from "./PieGraph";
import LineGraph from "./LineGraph";
import './App.css'

function App() {
  return (
    <div style={{backgroundColor: '#19323E', margin: '0px'}}>
      <div style={{height: "90px", width:"100%", backgroundColor: '#19355E' }}></div>
      
      <div style={{display: "flex", flexWrap:"wrap"}}>
        <div style={{border: "3px solid #1C4356", borderRadius: "9px", width:"43%", marginLeft:"3%", marginRight: "1%", marginTop: "2vh", marginBottom: "2vh", padding:"1%"}}>
          <PieGraph/>
        </div>
        <div style={{border: "3px solid #1C4356", borderRadius: "9px", width:"43%", marginLeft:"1%", marginTop: "2vh", padding:"1%", marginBottom: "2vh",}}>
          <LineGraph reqPath="/OverallMarketCap"/>
        </div>
        <div style={{width: "43%", marginLeft: "3%", marginRight: "1%",  padding: "1%",border: "3px solid #1C4356", borderRadius: "9px"}}>
          <LineGraph reqPath="/BestCoin"/>
        </div>
        <div style={{width: "43%", marginLeft: "1%", marginRight: "3%",  padding: "1%",border: "3px solid #1C4356", borderRadius: "9px"}}>
          <LineGraph reqPath="/WorstCoin"/>
        </div>
        <div style={{width: "43%", marginLeft: "3%", marginRight: "1%",  padding: "1%",border: "3px solid #1C4356", borderRadius: "9px"}}>
          <LineGraph reqPath="/Coin/BTC"/>
        </div>
        <div style={{width: "43%", marginLeft: "1%", marginRight: "3%",  padding: "1%",border: "3px solid #1C4356", borderRadius: "9px"}}>
          <LineGraph reqPath="/Coin/ETH"/>
        </div>
        
      </div>
    </div>
  );
 }

export default App;