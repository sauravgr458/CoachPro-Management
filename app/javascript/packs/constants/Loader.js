import React from "react"
import Spinner from 'react-bootstrap/Spinner';

function Loader() {
    return (
        <div className="d-flex justify-content-center align-items-center h-100-vh">
            <Spinner animation="grow" />;
        </div>
    )

}

export default Loader;