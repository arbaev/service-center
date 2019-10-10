# frozen_string_literal: true

class OrganizationSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :org_type

  attributes :name
  attributes :inn
  attributes :ogrn
end
