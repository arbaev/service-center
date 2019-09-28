# frozen_string_literal: true

require 'rails_helper'

feature 'List of all Clients', js:true do
  given(:staff) { create(:staff) }

  background do
    visit new_staff_session_path
    sign_in staff
    visit staff_home_index_path
  end

  context 'there are some clients' do
    given!(:clients) { create_list(:client, 5) }

    scenario 'show when requested' do
      list = page.find('#clients-list ul').all('li').collect(&:text)

      expect(list.size).to eq clients.size
    end
  end

  context 'there are no clients' do
    scenario 'not show if empty' do
      expect(page).to_not have_selector('#clients-list')
    end
  end
end
