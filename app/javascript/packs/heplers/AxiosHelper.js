import axios from "axios"

const getAxiosProps = (apiDetails) => {
    let {
        method,
        url,
        data,
        header = {},
        params,
    } = apiDetails
    return ({
        method,
        url,
        params,
        data,
        headers: {
            "Authorization": localStorage.getItem("accessToken"),
            "content-type": "application/json",
            'Accept': "application/json",
            ...header
        }
    })

}

const AxiosAPIHelper = async (details) => {
    let { method = 'get', url, header, data, params } = details
    let responseData = ''
    let responseError = ''
    let authorizationToken = ''
    try {
        const response = await axios(getAxiosProps({
            method,
            url,
            header,
            data,
            params
        }))

        if ([200, 202].includes(response.status)) {
            responseData = await response.data
            authorizationToken = await response.headers.authorization
        }
    } catch (error) {
        responseError = await error.response.data || error.message
    }

    return { error: responseError, response: responseData, token: authorizationToken }

}

export default AxiosAPIHelper