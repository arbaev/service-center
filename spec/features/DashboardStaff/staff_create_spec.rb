# frozen_string_literal: true

require 'rails_helper'

feature 'Staff user can create another Staff user', js: true do
  given(:staff) { create(:staff) }
  given(:staff_new) { build(:staff) }
  given!(:staff_old) { create(:staff) }

  background do
    visit new_staff_session_path
    sign_in staff
    visit '/staffs'
  end

  scenario 'creating the Staff user' do
    fill_in 'Staff email', with: staff_new.email
    fill_in 'Enter password', with: staff_new.password
    fill_in 'Repeat password', with: staff_new.password
    sleep 3 # unstable under VirtualBox without wait 3 sec minimum :-(
    click_on 'Create new Staff user'

    within '#staffs-list' do
      expect(page).to have_content staff_new.email
    end
  end

  describe 'does not create new Staff user' do
    context 'with wrong email:' do
      scenario 'when empty input' do
        fill_in 'Staff email', with: ''
        fill_in 'Enter password', with: staff_new.password

        expect(page).to have_content 'Field is required'
        expect(page).to have_button 'Create new Staff user', disabled: true
      end

      scenario 'when incorrect email' do
        fill_in 'Staff email', with: 'mail@ru'
        fill_in 'Enter password', with: staff_new.password

        expect(page).to have_content 'Enter correct email'
        expect(page).to have_button 'Create new Staff user', disabled: true
      end
    end

    context 'with wrong password:' do
      scenario 'when empty input' do
        fill_in 'Enter password', with: ''
        fill_in 'Staff email', with: staff_new.email

        expect(page).to have_content 'Field is required'
        expect(page).to have_button 'Create new Staff user', disabled: true
      end
    end
  end
end
