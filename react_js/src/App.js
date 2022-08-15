import React from "react";
import StartPage from "./StartPage"
import DetailPage from "./DetailPage";
import { Routes, Route, useParams } from 'react-router-dom';

function App() {
  return (
    <div className="App">
    <Routes> {/* The Switch decides which component to show based on the current URL.*/}
      <Route path='/' element={<StartPage/>} />
      <Route path=":asf" element={<DetailPage/>} />
    </Routes>
    </div>
  );
}

export default App;