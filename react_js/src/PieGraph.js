// src/components/pie.rechart.js

import React from "react";
import { PieChart, Pie, Cell, Tooltip, Legend } from 'recharts';
import { useEffect } from 'recharts';


class PieRechartComponent extends React.Component {

    COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#AF19FF'];
    pieData = [];

    constructor(){
        super()
        this.pieData = this.getData();
    }
    CustomTooltip = ({ active, payload, label }) => {
        if (active) {
            return (
                <div className="custom-tooltip" style={{ backgroundColor: '#ffff', padding: '5px', border: '1px solid #cccc' }}>
                    <label>{`${payload[0].name} : ${payload[0].value}%`}</label>
                </div>
            );
        }

        return null;
    };

    // getData(){
    //   return fetch('http://localhost:8000/MarketCap')
    //   .then((response) => { 
    //       return response.json().then((data) => {
    //           // console.log(data);
    //           return data;
    //       }).catch((err) => {
    //           console.log(err);
    //       }) 
    //   });
    // }
    async getData(){
        let obj;
        const res = await fetch('http://localhost:8000/MarketCap')
        obj = await res.json();
        console.log(obj)
        return obj;
    }


    // getData(){
    //     console.log("Heeeelo getData Läuft");
    //     var requestdata = [];
    //     fetch('http://localhost:8000/MarketCap')
    //       .then(response => response.json())
    //       // .then(data => requestdata = [Object.entries(data)]);
    //       .then(data => this.pieData.push(data));
    //     // console.log(requestdata);
    //     // this.pieData = requestdata;
    // }

    render() {
        console.log(this.pieData);
        return (
            <PieChart width={730} height={300}>
                <Pie data={this.pieData} color="#000000" dataKey="value" nameKey="name" cx="50%" cy="50%" outerRadius={120} fill="#8884d8" >
                    {
                        this.pieData.map((entry, index) => <Cell key={`cell-${index}`} fill={this.COLORS[index % this.COLORS.length]} />)
                    }
                </Pie>
                <Tooltip content={<this.CustomTooltip />} />
                <Legend />
            </PieChart>
        )
    };
}

export default PieRechartComponent;