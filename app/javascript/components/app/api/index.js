import axios from 'axios'

const adapter = axios.create({
  baseURL: '/'
});

const backend = {
  client: {
    user: () => adapter.get('/client/user')
  },
  staff: {
    user: () => adapter.get('/staff/user'),
    clients: () => adapter.get('/staff/client'),
    createClient: (client) => adapter.post('/staff/client', client),
    deleteClient: (id) => adapter.delete(`/staff/client/${id}`),
    validateClient: (client) => adapter.post('/staff/client/validation', client),
    orgTypes: () => adapter.get('/staff/org_type'),
    organizations: () => adapter.get('/staff/organization'),
    deleteOrganization: (id) => adapter.delete(`/staff/organization/${id}`),
    createOrganization: (organization) => adapter.post('/staff/organization',
      { organization: organization }),
  }
};

export { backend }
