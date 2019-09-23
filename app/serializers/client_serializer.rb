class ClientSerializer
  include FastJsonapi::ObjectSerializer

  attributes :fullname
  attributes :phone
  attributes :email
end
