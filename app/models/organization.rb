# frozen_string_literal: true

class Organization < ApplicationRecord
  belongs_to :org_type

  validates :name, :inn, :ogrn, presence: true
end
