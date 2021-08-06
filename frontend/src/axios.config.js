import axios from 'axios';

export const API = axios.create({
    baseURL: `http://localhost:3000/api/`,
    timeout: 1000,
    headers: {
        Authorization: 'Bearer' + localStorage.getItem('token')
    }
});
