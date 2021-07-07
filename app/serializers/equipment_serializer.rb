# frozen_string_literal: true

class EquipmentSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :organization

  attributes :name
  attributes :kind
  attributes :sn
end
