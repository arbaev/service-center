# frozen_string_literal: true

require 'rails_helper'

feature 'List of all Clients', js:true do
  given(:staff) { create(:staff) }

  background do
    visit new_staff_session_path
    sign_in staff
    visit '/clients'
  end

  context 'there are some clients' do
    given!(:clients) { create_list(:client, 5) }

    scenario 'show first page of list' do
      within('#clients-list-table table') do
        list = find('tbody').all('tr').collect(&:text)
        expect(list.size).to eq clients.count
      end
    end

    scenario 'table has all required fields' do
      within('#clients-list-table table') do
        expect(page).to have_content clients.first.fullname
        expect(page).to have_content clients.first.phone
        expect(page).to have_content clients.first.email

        expect(page).to have_content clients.last.fullname
        expect(page).to have_content clients.last.phone
        expect(page).to have_content clients.last.email
      end
    end
  end

  context 'there are no clients' do
    scenario 'show empty table' do
      within('#clients-list-table') do
        sleep 3 # waiting for list loading
        expect(page).to have_content 'No clients yet'
      end
    end
  end
end
