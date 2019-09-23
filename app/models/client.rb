# frozen_string_literal: true

class Client < ApplicationRecord
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  validates :fullname, :phone, presence: true
  validates :fullname, length: { minimum: 5 }
  # validates :phone, numericality: { only_integer: true }
end
