import { useState } from "react";
import * as React from 'react';
import './App.css';
import { XIcon, SearchIcon } from '@heroicons/react/solid';
import { useNavigate } from "react-router-dom";


var data = require("./data.json");




function SearchBar() {
  const navigate = useNavigate();
  const [value, setValue] = useState("");

  const onChange = (event) => {
    setValue(event.target.value);
  };

  const onSearch = (searchTerm) => {
    setValue(searchTerm);
    // our api to fetch the search result
    navigate("/" + searchTerm);
    window.location.reload(false);
  };  
  const handleKeyDown = (event) => {
    if (event.key === 'Enter') {
      console.log(value);
      navigate("/" + value);
      window.location.reload(false);
    }
  }


  return(
  <>
    
    <div className="search-container">
      
      <div className="search-inner">
        <input type="text" value={value} onChange={onChange} onKeyDown={handleKeyDown} />
        <SearchIcon className="search-icon" onClick={() => onSearch(value)}/>
      </div>
      <div className="dropdown">
        {data
          .filter((item) => {
            const searchTerm = value.toLowerCase();
            const fullName = item.fullname.toLowerCase();
            return (
              searchTerm &&
              fullName.startsWith(searchTerm) 
            );
          })
          .slice(0, 10)
          .map((item) => (
            <div
              onClick={() => onSearch(item.fullname)}
              className="dropdown-row"
              key={item.fullname}
            >
              {item.fullname}
            </div>
          ))}
      </div>
    </div>
    </>
    )
}

export default SearchBar;