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
    // staff
    staffs: () => adapter.get('/staff/staff'),
    createStaff: (staff) => adapter.post('/staff/staff', { staff: staff }),
    updateStaff: (staff) => adapter.patch(`/staff/staff/${staff.id}`, { staff: staff }),
    resetPasswordStaff: (staff) => adapter.post(`/staff/staff/${staff.id}/reset_password`),
    // clients
    clients: () => adapter.get('/staff/client'),
    createClient: (client) => adapter.post('/staff/client', { client: client }),
    updateClient: (client) => adapter.patch(`/staff/client/${client.id}`, { client: client }),
    resetPasswordClient: (client) => adapter.post(`/staff/client/${client.id}/reset_password`),
    deleteClient: (id) => adapter.delete(`/staff/client/${id}`),
    validateClient: (client) => adapter.post('/staff/client/validation', client),
    // organizations
    orgTypes: () => adapter.get('/staff/org_type'),
    organizations: () => adapter.get('/staff/organization'),
    deleteOrganization: (id) => adapter.delete(`/staff/organization/${id}`),
    createOrganization: (organization) => adapter.post('/staff/organization',
      { organization: organization }),
    // equipments
    equipments: () => adapter.get('/staff/equipment'),
    updateEquipment: (eq) => adapter.patch(`/staff/equipment/${eq.id}`, { equipment: eq, organization_id: eq.organization_id }),
  }
};

export { backend }
