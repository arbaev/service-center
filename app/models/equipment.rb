class Equipment < ApplicationRecord
  belongs_to :organization

  validates :name, :type, :sn, presence: true
end
