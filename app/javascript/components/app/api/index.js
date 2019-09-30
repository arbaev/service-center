import axios from 'axios'

export function backendGet(url) {
  return axios.get(url);
}

export function backendPost(url, params) {
  return axios.post(url, params);
}
