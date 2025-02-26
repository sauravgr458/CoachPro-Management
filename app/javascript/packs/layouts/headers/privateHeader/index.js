import React from "react";
import Logo from "./../../../assets/cp-logo.png"
import { Link, json, useNavigate } from "react-router-dom";

const PrivateHeader = () => {
  const userToken = localStorage.getItem("accessToken");
  const user = JSON.parse(localStorage.getItem("user"));
  let type = user?.type
  const companySlug = user?.company_slug
  const navigate = useNavigate();
  const handleLogOut = () => {
    localStorage.clear();
    navigate("/");
  };
  return (
    <header>
      <nav className="navbar navbar-expand-lg navbar-dark bg-dark">
        <div className='container-fluid'>
          <Link to="/" className="navbar-brand" >
            <img src={Logo} className='main-logo' />
          </Link>
          <button className="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
            <span className="navbar-toggler-icon"></span>
          </button>
          <div className="collapse navbar-collapse" id="navbarText">
            <ul className="navbar-nav mr-auto">
              <li className="nav-item">
                <Link to={`${type}/dashboard`} className="nav-link" >
                  Dashboard
                </Link>
              </li>
              {companySlug &&
                <li className="nav-item">
                  <Link to={`${type}/company/${companySlug}`} className="nav-link" >
                    Company Dashboard
                  </Link>
                </li>
              }
            </ul>
            <div className="navbar-text">
              {
                userToken ? (
                  <></>
                ) : (
                  <>
                    <Link to="/login" className="nav-link" >
                      Login
                    </Link>
                    <span>&nbsp;</span>
                  </>
                )
              }
              <Link className="auth text-black nav-link" onClick={handleLogOut} >
                Log Out
              </Link>
            </div>
          </div>
        </div>
      </nav>
    </header>
  );
}

export default PrivateHeader;
