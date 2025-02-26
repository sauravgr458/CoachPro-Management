import React from 'react';
import { Link, useParams } from 'react-router-dom';
import Logo from "./../../../assets/cp-logo.png"

const LandingPageHeader = () => {
  const { company_slug } = useParams();

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
              {/* <li className="nav-item">
                <Link to="/dashboard" className="nav-link" >
                  Dashboard
                </Link>
              </li> */}
            </ul>
            <div className="navbar-text">
              <Link to="/login" className="nav-link" >
                Login
              </Link>
              {company_slug ? (
                <>
                  <span>&nbsp;</span>
                  <Link to={`/company/${company_slug}/sign-up`} className="nav-link" >
                    Signup
                  </Link>
                </>
              ) : (
                <></>
              )}
            </div>
          </div>
        </div>
      </nav>
    </header>
  );
}

export default LandingPageHeader;
