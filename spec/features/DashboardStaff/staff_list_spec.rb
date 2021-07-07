# frozen_string_literal: true

require 'rails_helper'

feature 'List of all Staff users', js:true do
  given!(:staffs) { create_list(:staff, 5) }
  given(:staff) { staffs.sample }

  background do
    visit new_staff_session_path
    sign_in staff
    visit '/staffs'
  end

  context 'there are some Staff users' do
    scenario 'show first page of list' do
      within('#staffs-list-table table') do
        list = find('tbody').all('tr').collect(&:text)
        expect(list.size).to eq staffs.count
      end
    end

    scenario 'table has all required fields' do
      within('#staffs-list-table table') do
        expect(page).to have_content staffs.first.email

        expect(page).to have_content staffs.last.email
      end
    end
  end
end
