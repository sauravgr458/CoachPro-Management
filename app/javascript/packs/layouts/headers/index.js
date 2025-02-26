import React, { useEffect, useState } from "react";
import "./Headers.css";
import LandingPageHeader from "./LandingHeader";
import PrivateHeader from "./privateHeader";
import { useLocation } from "react-router-dom";
const Headers = (props) => {
  const [userType , setUserType] = useState('')
  let location = useLocation()
  let userDetails = JSON.parse(localStorage.getItem("user"));
  let type = userDetails?.type || "";
  useEffect(() => {
    console.log(userDetails , "::: userDetails", type);
    setUserType(type)
  },[location.pathname])
  return userType ? (
    <PrivateHeader />
  ) : <LandingPageHeader />;
};

export default Headers;
