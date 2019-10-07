# frozen_string_literal: true

require 'rails_helper'

feature 'List of all Organizations', js: true do
  given(:staff) { create(:staff) }

  background do
    visit new_staff_session_path
    sign_in staff
    visit staff_home_index_path
    find('#dashboard-organizations').click
  end

  context 'there are some organizations' do
    given!(:organizations) { create_list(:organization, 5) }

    scenario 'show when requested' do
      list = page.find('#organizations-list ul').all('li').collect(&:text)

      expect(list.size).to eq organizations.count
    end
  end

  context 'there are no clients' do
    scenario 'not show if empty' do
      expect(page).to_not have_selector('#organizations-list')
    end
  end
end
