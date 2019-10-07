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
    find('#tab-clients').click
  end

  scenario 'creating the Client' do
    fill_in 'Your full name', with: client.fullname
    fill_in 'Your phone number', with: client.phone
    fill_in 'Your email', with: client.email
    fill_in 'Enter password', with: client.password
    sleep 3 # unstable under VirtualBox without wait 3 sec minimum :-(
    click_on 'Create new client'

    within '#clients-list' do
      expect(page).to have_content client.email
    end
  end

  describe 'does not create new client' do
    context 'with wrong fullname:' do
      scenario 'when empty input' do
        fill_in 'Your full name', with: ''
        fill_in 'Your phone number', with: client.phone

        expect(page).to have_content 'Field is required'
        expect(page).to have_button 'Create new client', disabled: true
      end

      scenario 'when missing letters' do
        fill_in 'Your full name', with: 'abc'
        fill_in 'Your phone number', with: client.phone

        expect(page).to have_content 'Please use mimimum 5 characters'
        expect(page).to have_button 'Create new client', disabled: true
      end

      scenario 'when digits in fullname' do
        fill_in 'Your full name', with: '78946513'
        fill_in 'Your phone number', with: client.phone

        expect(page).to have_content 'Only letters are allowed'
        expect(page).to have_button 'Create new client', disabled: true
      end
    end

    context 'with wrong phone:' do
      scenario 'when empty input' do
        fill_in 'Your phone number', with: ''
        fill_in 'Your full name', with: client.fullname

        expect(page).to have_content 'Field is required'
        expect(page).to have_button 'Create new client', disabled: true
      end

      scenario 'when letters in input' do
        fill_in 'Your phone number', with: 'abc'
        fill_in 'Your full name', with: client.fullname

        expect(page).to have_content 'Field is required'
        expect(page).to have_button 'Create new client', disabled: true
      end

      scenario 'when missing digits' do
        fill_in 'Your phone number', with: '1324654'
        fill_in 'Your full name', with: client.fullname

        expect(page).to have_content 'Please use 10 digits'
        expect(page).to have_button 'Create new client', disabled: true
      end

      scenario 'when phone has already been taken' do
        fill_in 'Your phone number', with: client_old.phone
        fill_in 'Your full name', with: client_old.fullname
        sleep 3 # unstable under VirtualBox without wait 3 sec minimum :-(

        expect(page).to have_content 'phone has already been taken'
        expect(page).to have_button 'Create new client', disabled: true
      end
    end

    context 'with wrong email:' do
      scenario 'when empty input' do
        fill_in 'Your email', with: ''
        fill_in 'Your full name', with: client.fullname

        expect(page).to have_content 'Field is required'
        expect(page).to have_button 'Create new client', disabled: true
      end

      scenario 'when incorrect email' do
        fill_in 'Your email', with: 'mail@ru'
        fill_in 'Your full name', with: client.fullname

        expect(page).to have_content 'Enter correct email'
        expect(page).to have_button 'Create new client', disabled: true
      end

      scenario 'when email has already been taken' do
        fill_in 'Your email', with: client_old.email
        fill_in 'Enter password', with: client_old.fullname
        sleep 3 # unstable under VirtualBox without wait 3 sec minimum :-(

        expect(page).to have_content 'email has already been taken'
        expect(page).to have_button 'Create new client', disabled: true
      end
    end

    context 'with wrong password:' do
      scenario 'when empty input' do
        fill_in 'Enter password', with: ''
        fill_in 'Your full name', with: client.fullname

        expect(page).to have_content 'Field is required'
        expect(page).to have_button 'Create new client', disabled: true
      end
    end
  end
end
