# frozen_string_literal: true

class Client < ApplicationRecord
  has_many :orders
  has_many :organizations, through: :orders, dependent: :destroy

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  before_validation :phone_normalize

  validates :fullname, :phone, presence: true
  validates :fullname, format: { with: /[A-z А-яЁё]{5,}/,
                                 message: 'only allows letters, 5 letters minimum' }
  validates :phone, length: { is: 10 }, format: { with: /[0-9]{10}/ }
  validates :phone, uniqueness: true

  private

  def phone_normalize
    self.phone = phone&.gsub(/\D/, '')
  end
end
