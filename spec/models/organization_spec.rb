require 'rails_helper'

RSpec.describe Organization, type: :model do
  it { should belong_to(:org_type) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :inn }
  it { should validate_presence_of :ogrn }
end
