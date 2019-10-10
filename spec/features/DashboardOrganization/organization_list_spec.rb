# frozen_string_literal: true

require 'rails_helper'

feature 'List of all Organizations', js: true do
  given(:staff) { create(:staff) }

  background do
    visit new_staff_session_path
    sign_in staff
  end

  context 'there are some organizations' do
    given!(:organizations) { create_list(:organization, 5) }

    background do
      visit staff_home_index_path
      find('#dashboard-organizations').click
    end

    scenario 'show first page of list' do
      within('#organizations-list-table table') do
        list = find('tbody').all('tr').collect(&:text)
        expect(list.size).to eq organizations.count
      end
    end

    scenario 'table has all required fields' do
      within('#organizations-list-table table') do
        expect(page).to have_content organizations.first.name
        expect(page).to have_content organizations.first.org_type.name
        expect(page).to have_content organizations.first.inn
        expect(page).to have_content organizations.first.ogrn

        expect(page).to have_content organizations.last.name
        expect(page).to have_content organizations.last.org_type.name
        expect(page).to have_content organizations.last.inn
        expect(page).to have_content organizations.last.ogrn
      end
    end
  end

  context 'there are no organizations' do
    scenario 'show empty table' do
      within('#organizations-list-table') do
        sleep 3 # waiting for list loading
        expect(page).to have_content 'No organizations yet'
      end
    end
  end
end
