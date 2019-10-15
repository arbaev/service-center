# frozen_string_literal: true

require 'rails_helper'

feature 'Staff user can delete the client', js: true do
  given(:staff) { create(:staff) }
  given!(:clients) { create_list(:client, 5) }
  given(:client) { clients.sample }

  background do
    visit new_staff_session_path
    sign_in staff
    visit staff_home_index_path
    find('#tab-clients').click
  end

  scenario 'deleting the client' do
    within('#clients-list-table table') do
      expect(page).to have_content client.fullname

      tr = find('tr', text: client.fullname)
      tr.find('.action-delete').click

      expect(page).to_not have_content client.fullname
    end
  end
end
