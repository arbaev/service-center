class OrgType < ApplicationRecord
  has_many :organizations, dependent: :destroy

  validates :name, presence: true
end
