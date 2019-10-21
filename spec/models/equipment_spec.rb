require 'rails_helper'

RSpec.describe Equipment, type: :model do
  it { should belong_to :organization }

  it { should validate_presence_of :name }
  it { should validate_presence_of :kind }
  it { should validate_presence_of :sn }
end
