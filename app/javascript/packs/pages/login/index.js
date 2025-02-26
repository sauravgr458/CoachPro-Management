import React, { useState } from "react";
import "./Login.css";
import { Link, useNavigate } from "react-router-dom";
import { Container, Row, Col, Form, Button } from 'react-bootstrap';
import AxiosAPIHelper from "../../heplers/AxiosHelper";

const Login = () => {
  const navigate = useNavigate();
  const [errors, setErrors] = useState({})

  const handleFormSubmit = async (event) => {
    event.preventDefault();
    const formData = new FormData(event.target);
    let data = Object.fromEntries(formData.entries());
    let { response, error, token } = await AxiosAPIHelper({ method: 'post', url: '/users/sign_in', data })

    if (response) {
      setErrors((prev) => ({
        ...prev,
        formError: ''
      }))
      localStorage.setItem("user", JSON.stringify({ ...response.data }));
      localStorage.setItem("accessToken", token); 
      if(response.data?.type === 'coach'){
        navigate(`coach/dashboard`)
      }else{
        navigate(`/company/${response?.data?.company_slug}`)
      }
    }
    else if (error) {
      let errormessage = error?.errors
      setErrors((prev) => ({
        ...prev,
        formError: errormessage
      }))
      window.scrollTo({
        top: 0,
        behavior: 'smooth'
      });
    }
  };

  return (
    <Container fluid className="ps-md-0">
      <Row className="">
        <Col className="d-none d-md-flex col-md-4 col-lg-6 bg-image"></Col>
        <Col md={8} lg={6}>
          <div className="login d-flex align-items-center py-5">
            <Col md={9} lg={8} mx-auto='true'>
              <h3 className="login-heading mb-4">Welcome back!</h3>
              {
                errors?.formError &&
                <div className="border border-danger rounded sign-up-error-message mb-2">
                  {errors?.formError}
                </div>
              }
              <Form onSubmit={handleFormSubmit}>
                <Form.Group className="mb-3" controlId="floatingInput">
                  <Form.Label>Email address</Form.Label>
                  <Form.Control
                    type="email"
                    placeholder="name@example.com"
                    name="email"
                    required
                  />
                </Form.Group>
                <Form.Group className="mb-3" controlId="floatingPassword">
                  <Form.Label>Password</Form.Label>
                  <Form.Control
                    type="password"
                    placeholder="Password"
                    name="password"
                    required
                  />
                </Form.Group>
                <Form.Group className="mb-3" controlId="rememberPasswordCheck">
                  <Form.Check
                    type="checkbox"
                    label="Remember password"
                    id="rememberPasswordCheck"
                  />
                </Form.Group>
                <div className="d-grid">
                  <Button
                    variant="primary"
                    size="lg"
                    className="btn-login text-uppercase fw-bold mb-2"
                    type="submit"
                  >
                    Sign in
                  </Button>
                </div>
              </Form>
            </Col>
          </div>
        </Col>
      </Row>
    </Container>
  );
};

export default Login;