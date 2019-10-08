# frozen_string_literal: true

class OrganizationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name
  has_many :organizations
end
