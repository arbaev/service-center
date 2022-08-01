require 'rails_helper'

RSpec.describe Client, type: :model do
  it { should have_many(:orders) }
  it { should have_many(:organizations).through(:orders).dependent(:destroy) }

  it { should validate_presence_of :email }

  describe 'fullname validations' do
    it { should validate_presence_of :fullname }
    it { should allow_value('Ivan Ivanov').for(:fullname) }
    it { should allow_value('Иван Иванов').for(:fullname) }
      invalid_fullnames = ['', ' ', 'joe', 'joe1']
    invalid_fullnames.each do |item|
      it { should_not allow_value(item).for(:fullname) }
    end
  end

  describe 'phone validations' do
    it { should validate_presence_of :phone }
    it { should allow_value('(111)123-12-45').for :phone }
    invalid_phones = [' ', '111', ' 9321903', 'gkdjsh', '-', '123h113h123', '12345678900', '0123456798789' ]
    invalid_phones.each do |item|
      it { should_not allow_value(item).for :phone }
    end
  end
end
