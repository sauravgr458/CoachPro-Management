import React, { useState } from 'react';
// import { acceptCoachInvitation } from './../common/Api';
import { useNavigate } from 'react-router-dom';
import AxiosAPIHelper from '../../heplers/AxiosHelper';
import { Button, Col, Container, Form, Row } from 'react-bootstrap';

const AcceptInvitation = () => {
    const queryParameters = new URLSearchParams(window.location.search)
    const invitation_token = queryParameters.get("invitation_token")
    const [errors, setErrors] = useState({})

    const navigate = useNavigate();

    const handleSubmit = async (event) => {
        event.preventDefault();
        const formData = new FormData(event.target);
        let { password, password_confirmation } = Object.fromEntries(formData.entries());

        let userData = {
            invitation_token,
            password,
            password_confirmation
        }
        let { response, error } = await AxiosAPIHelper({ method: 'put', url: '/users/invitation', data: { user: userData } })
        if (response) {
            setErrors((prev) => ({
                ...prev,
                formError: ''
            }))
            navigate('/')
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
            <Row className="d-flex align-items-center justify-content-center vh-100">
                <Col md={8} lg={6}>
                    <div className="d-flex align-items-center justify-content-center vh-100">
                        <Col md={9} lg={8} mx-auto>
                            <h3 className="login-heading mb-4">Accept Invitation</h3>
                            {
                                errors?.formError &&
                                <div className="border border-danger rounded sign-up-error-message mb-2">
                                    {errors?.formError}
                                </div>
                            }
                            <Form onSubmit={handleSubmit}>
                                <Form.Group className="mb-3" controlId="floatingPassword">
                                    <Form.Label>Password</Form.Label>
                                    <Form.Control
                                        type="password"
                                        placeholder="Password"
                                        name="password"
                                        required
                                    />
                                </Form.Group>
                                <Form.Group className="mb-3" controlId="floatingPassword">
                                    <Form.Label>Password Confirmation</Form.Label>
                                    <Form.Control
                                        type="password"
                                        placeholder="Password Confirmation"
                                        name="password_confirmation"
                                        required
                                    />
                                </Form.Group>
                                <div className="d-grid">
                                    <Button
                                        variant="primary"
                                        size="lg"
                                        className="btn-login text-uppercase fw-bold mb-2"
                                        type="submit"
                                    >
                                        Submit
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

export default AcceptInvitation;
