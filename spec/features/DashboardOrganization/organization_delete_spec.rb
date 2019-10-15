# frozen_string_literal: true

require 'rails_helper'

feature 'Staff user can delete the organization', js: true do
  given(:staff) { create(:staff) }
  given!(:organizations) { create_list(:organization, 5) }
  given(:org) { organizations.sample }

  background do
    visit new_staff_session_path
    sign_in staff
    visit '/organizations'
  end

  scenario 'deleting the organization' do
    within('#organizations-list-table table') do
      expect(page).to have_content org.name

      tr = find('tr', text: org.name)
      tr.find('.action-delete').click

      expect(page).to_not have_content org.name
    end
  end
end
