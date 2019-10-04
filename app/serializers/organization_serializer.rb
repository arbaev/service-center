# frozen_string_literal: true

class OrganizationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name
  attributes :inn
  attributes :ogrn
end
