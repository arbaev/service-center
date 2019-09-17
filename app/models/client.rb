# frozen_string_literal: true

class Client < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable
end
