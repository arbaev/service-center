# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :organization
  belongs_to :client
end
