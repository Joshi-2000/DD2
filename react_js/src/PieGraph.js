// src/components/pie.rechart.js

import React from "react";
import { PieChart, Pie, Cell, Tooltip, Legend, ResponsiveContainer} from 'recharts';
import './App.css'

class PieRechartComponent extends React.Component {


    constructor(props){
        super(props);
        this.state = {
            COLORS3: ['#e6194b', '#3cb44b', '#ffe119', '#4363d8', '#f58231', '#911eb4', '#46f0f0', '#f032e6', '#bcf60c', '#fabebe', '#008080', '#e6beff', '#9a6324', '#fffac8', '#800000', '#aaffc3', '#808000', '#ffd8b1', '#000075', '#808080', '#000000'],
            COLORS: [
                '#8eee79',
                '#70e381',
                '#51d788',
                '#2fca8d',
                '#00bd91',
                '#00b093',
                '#00a393',
                '#009590',
                '#00888c',
                '#007a85',
                '#006d7c',
                '#006071'].reverse(),
            pieData: [],
            DataisLoaded: false
        };
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

    componentDidMount() {
        fetch('http://localhost:8000/MarketCap')
            .then((res) => res.json())
            .then((json) => { 
                this.setState({
                    pieData: json,
                    DataisLoaded: true
                });
            })
    }

    render() {
        const { DataisLoaded, pieData, COLORS} = this.state;
        if (!DataisLoaded) return <div>
            <h1> Please wait some time.... </h1> </div> ;
        return (
            <>
            <p class="headline-center">Market Capitalization</p>
            <ResponsiveContainer height={400} >

                <PieChart width={730} height={300}>
                    <Pie data={pieData} color="#000000" dataKey="value" nameKey="name" cx="50%" cy="50%" outerRadius={150} >
                        {
                            pieData.map((entry, index) => <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]}  />)
                        }
                    </Pie>
                    <Tooltip content={<this.CustomTooltip />} />
                    <Legend />
                </PieChart>
            </ResponsiveContainer>
            </>
        )

    };
}

export default PieRechartComponent;