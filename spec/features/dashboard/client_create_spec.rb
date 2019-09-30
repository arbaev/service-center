# frozen_string_literal: true

require 'rails_helper'

feature 'Staff user can create Client user', js: true do
  given(:staff) { create(:staff) }
  given(:client) { build(:client) }
  given!(:client_old) { create(:client) }

  background do
    visit new_staff_session_path
    sign_in staff
    visit staff_home_index_path
  end

  scenario 'creating the Client' do
    fill_in 'fullname', with: client.fullname
    fill_in 'phone', with: client.phone
    fill_in 'email', with: client.email
    fill_in 'password', with: client.password
    sleep 3 # unstable under VirtualBox without wait 3 sec minimum :-(
    click_on 'Create new client'

    within '#clients-list' do
      expect(page).to have_content client.email
    end
  end

  describe 'does not create new client' do
    scenario 'with wrong fullname' do
      fill_in 'fullname', with: '123'
      fill_in 'phone', with: client.phone

      expect(page).to have_content 'Five letters minimum, no digits allowed'
      expect(page).to have_button 'Create new client', disabled: true
    end

    scenario 'with wrong phone' do
      fill_in 'phone', with: 'abc'
      fill_in 'fullname', with: client.fullname

      expect(page).to have_content 'Enter 10 digits'
      expect(page).to have_button 'Create new client', disabled: true
    end

    scenario 'with wrong email' do
      fill_in 'email', with: 'mail@ru'
      fill_in 'fullname', with: client.fullname

      expect(page).to have_content 'Enter correct email'
      expect(page).to have_button 'Create new client', disabled: true
    end

    scenario 'with has already been taken attributes' do
      fill_in 'email', with: client_old.email
      fill_in 'password', with: client_old.fullname
      sleep 3 # unstable under VirtualBox without wait 3 sec minimum :-(

      fill_in 'phone', with: client_old.phone
      fill_in 'fullname', with: client_old.fullname
      sleep 3 # unstable under VirtualBox without wait 3 sec minimum :-(

      expect(page).to have_content 'phone has already been taken'
      expect(page).to have_content 'email has already been taken'
    end

  end
end
