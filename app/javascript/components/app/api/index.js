import axios from 'axios'

export function backendGet(url) {
  return axios.get(url);
}

export function backendPost(url, params) {
  return axios.post(url, params);
}

export function backendDelete(url, id) {
  return axios.delete(`${url}/${id}`);
}

const adapter = axios.create({
  baseURL: '/'
});

const backend = {
  client: {
    user: () => adapter.get('/client/user')
  },
  staff: {
    user: () => adapter.get('/staff/user'),
  }
};

export { backend }
