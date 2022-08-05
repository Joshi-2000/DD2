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
          <p class="headline-center">General information</p>
          <p class= "text">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>
        </div>
        <div style={{width: "43%", marginLeft: "3%", marginRight: "1%",  padding: "1%",border: "3px solid #1C4356", borderRadius: "9px"}}>
          <LineGraph Coin="BTC"/>
        </div>
        <div style={{width: "43%", marginLeft: "1%", marginRight: "3%",  padding: "1%",border: "3px solid #1C4356", borderRadius: "9px"}}>
          <LineGraph Coin="ETH"/>
        </div>
        
      </div>
    </div>
  );
 }

export default App;