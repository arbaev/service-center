# frozen_string_literal: true

class Equipment < ApplicationRecord
  belongs_to :organization, optional: true

  validates :name, :kind, :sn, presence: true
end
