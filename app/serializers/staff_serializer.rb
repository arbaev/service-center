# frozen_string_literal: true

class StaffSerializer
  include FastJsonapi::ObjectSerializer

  attributes :email
end
