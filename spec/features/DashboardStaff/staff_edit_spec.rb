# frozen_string_literal: true

require 'rails_helper'

feature 'Staff user can edit Client user', js: true do
  given(:staffs) { create_list(:staff, 7) }
  given(:staff_admin) { staffs.sample }
  given!(:staff) { staffs.sample }
  given(:staff_data) { build(:staff) }

  background do
    visit new_staff_session_path
    sign_in staff_admin
    visit '/staffs'

    tr = find('tr', text: staff.email)
    tr.find('.action-edit').click
  end

  scenario 'editing the Staff' do
    fill_in 'Staff email', with: staff_data.email
    sleep 3 # unstable under VirtualBox without wait 3 sec minimum :-(
    click_on 'Edit Staff user'

    within '#staffs-list' do
      expect(page).to have_content staff_data.email
    end
  end
end
