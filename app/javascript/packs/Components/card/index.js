import React from 'react';
import Button from 'react-bootstrap/Button';
import Card from 'react-bootstrap/Card';
import { useNavigate } from 'react-router-dom';

function CardComponent(props) {
    const { title, details, image, id, slug, companyId, companySlug, companyName } = props;
    const navigate = useNavigate();

    const navigateTo = () => {
        let userDetails = JSON.parse(localStorage.getItem("user"));
        navigate(userDetails ? `/${userDetails.type}/company/${companySlug}/program/${slug}-${companyId}-${id}` : '/');
    };

    return (
        <Card style={{ width: '95%', margin: '0 auto' }}>
            <Card.Img variant="top" src={image} />
            <Card.Body>
                <Card.Title>{title}</Card.Title>
                <Card.Text>{details}</Card.Text>
                {companyName ? (
                    <Card.Text>Company: {companyName}</Card.Text>
                ) : (
                    <></>
                )}
                {companyId && slug && id ? (
                    <Button variant="primary" onClick={navigateTo}>Views</Button>
                ) : (
                    <></>
                )}
            </Card.Body>
        </Card >
    );
}

export default CardComponent;
