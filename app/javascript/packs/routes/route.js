import React from "react";
import Headers from "../layouts/headers";
import { Navigate, Outlet } from "react-router-dom";

export const PrivateRoute = (props) => {
  const { type } = props;
  let userDetails = JSON.parse(localStorage.getItem("user"));
  let user = userDetails?.type || "";

  let userType = {
    coach: "coach",
    employee: "employee",
  };
  if (!user) {
    return <Navigate to={"/"} />;
  } else if (userType[type] !== user) {
    return <Navigate to={"/"} />;
  }
  return (
    <>
      <Headers type={user} />
      <Outlet />
    </>
  );
};

export const PublicRoute = () => {
  let userDetails = JSON.parse(localStorage.getItem("user"));
  let user = userDetails?.type || "";

  let userType = {
    coach: "dashboard",
    employee: "dashboard",
  };
  if (user) {
    return <Navigate to={`${user}/${userType[user]}`} />;
  }
  return (
    <>
      <Headers type={userType[user] || ""} />
      <Outlet />
    </>
  );
};
