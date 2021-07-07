# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :equipments, dependent: :destroy
  has_many :orders
  has_many :clients, through: :orders, dependent: :destroy
  belongs_to :org_type

  validates :name, :inn, :ogrn, presence: true
end
