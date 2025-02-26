import React, { useEffect, useState } from "react";
import { Container, Row, Col, Form, Button } from 'react-bootstrap';
import "./SignUp.css";
import AxiosAPIHelper from "../../heplers/AxiosHelper";
import { Link, useNavigate, useParams } from "react-router-dom";

const SignUp = () => {
  const { company_slug } = useParams();
  const [companies, setCompanies] = useState([])
  const [selectSlug, setSelectsSlug] = useState()
  const [errors, setErrors] = useState({})
  const navigate = useNavigate()
  useEffect(() => {
    getCompanyList()
  }, [])

  const getCompanyList = async () => {
    let { response, error } = await AxiosAPIHelper({ url: '/api/v1/companies' })
    if (response.length) {
      setCompanies(response)
      let slug = response.find((item) => item.slug === company_slug)
      setSelectsSlug(slug)

    } else {
      setErrors((prev) => ({
        ...prev,
        companiesError: error
      }))
    }
  }
  const handleFormSubmit = async (event) => {
    event.preventDefault();
    const formData = new FormData(event.target);
    let data = Object.fromEntries(formData.entries());
    let { response, error } = await AxiosAPIHelper({ method: 'post', url: '/users', data: { ...data, type: 'Employee', company_id: selectSlug ? selectSlug.id : data?.company_id } })
    if (response) {
      setErrors((prev) => ({
        ...prev,
        formError: ''
      }))
      navigate('/login')
    }
    else if (error) {
      let errormessage = error?.errors?.full_messages
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
            <Col md={9} lg={8} mx-auto>
              <h3 className="login-heading mb-4">Register as an Employee!</h3>
              {
                errors?.formError &&
                <ul className="border border-danger rounded sign-up-error-message">
                  {
                    errors?.formError.map((error, index) => {
                      return <li key={`form-error-${index}`}>{error}</li>
                    })
                  }
                </ul>
              }
              <Form onSubmit={handleFormSubmit}>
                <Row>
                  <Col md={12}>
                    <Form.Group className="mb-3" controlId="email">
                      <Form.Label>Email address</Form.Label>
                      <Form.Control
                        type="email"
                        placeholder="name@example.com"
                        name="email"
                        required
                      />
                    </Form.Group>
                  </Col>
                </Row>
                <Row>
                  <Col md={6}>
                    <Form.Group className="mb-3" controlId="first-name">
                      <Form.Label>First Name</Form.Label>
                      <Form.Control
                        type="text"
                        placeholder="First Name"
                        name="first_name"
                        required
                      />
                    </Form.Group>
                  </Col>
                  <Col md={6}>
                    <Form.Group className="mb-3" controlId="last-name">
                      <Form.Label>Last Name</Form.Label>
                      <Form.Control
                        type="text"
                        placeholder="Last Name"
                        name="last_name"
                        required
                      />
                    </Form.Group>
                  </Col>
                </Row>
                <Row>
                  <Col md={6}>
                    <Form.Group className="mb-3" controlId="language">
                      <Form.Label>Phone number</Form.Label>
                      <Form.Control
                        type="text"
                        placeholder="9999999999"
                        name="phone_number"
                        required
                      />
                    </Form.Group>
                  </Col>
                  <Col md={6}>
                    <Form.Group className="mb-3" controlId="company-name">
                      <Form.Label>Company</Form.Label>
                      {
                        company_slug ?
                          <Form.Control
                            type="text"
                            name="company_id"
                            required
                            value={selectSlug?.name}
                            disabled
                          />
                          :
                          <Form.Select name="company_id">
                            <option value='' >Select company</option>
                            {companies.map((company) => {
                              return (
                                <option value={company.id} key={company.id}>{company.name}</option>
                              )
                            })}
                          </Form.Select>
                      }

                    </Form.Group>
                  </Col>
                </Row>
                <Row>
                  <Col md={6}>
                    <Form.Group className="mb-3" controlId="job-title">
                      <Form.Label>Password</Form.Label>
                      <Form.Control
                        type="password"
                        placeholder="**********"
                        name="password"
                      />
                    </Form.Group>
                  </Col>
                  <Col md={6}>
                    <Form.Group className="mb-3" controlId="date">
                      <Form.Label>Confirm Password</Form.Label>
                      <Form.Control
                        type="password"
                        placeholder="**********"
                        name="password_confirmation"
                      />
                    </Form.Group>
                  </Col>
                </Row>
                <div className="d-grid">
                  <Button
                    variant="primary"
                    size="lg"
                    className="btn-login text-uppercase fw-bold mb-2"
                    type="submit"
                  >
                    Sign Up
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

export default SignUp;