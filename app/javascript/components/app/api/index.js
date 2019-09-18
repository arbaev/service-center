import axios from 'axios'

export function backendGet(url) {
    return axios.get(url);
}
