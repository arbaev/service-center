# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :equipments, dependent: :destroy
  belongs_to :org_type

  validates :name, :inn, :ogrn, presence: true
end
