import "./App.css";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import MainScreen from "./components/main_page/mainscreen.jsx";
import React from "react";

function App() {
  return (
    <React.Fragment>
      {
        <Router>
          <Routes>
            <Route path="/" element={<MainScreen />} />
          </Routes>
        </Router>
      }
    </React.Fragment>
  );
}

export default App;
