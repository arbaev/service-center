# frozen_string_literal: true

require 'rails_helper'

feature 'Staff user can edit Client user', js: true do
  given(:staff) { create(:staff) }
  given(:clients) { create_list(:client, 5) }
  given!(:client) { clients.sample }
  given(:client_data) { build(:client) }

  background do
    visit new_staff_session_path
    sign_in staff
    visit '/clients'

    tr = find('tr', text: client.fullname)
    tr.find('.action-edit').click
  end

  scenario 'editing the Client' do
    fill_in 'Client phone number', with: client_data.phone
    fill_in 'Client full name', with: client_data.fullname
    fill_in 'Client email', with: client_data.email
    sleep 3 # unstable under VirtualBox without wait 3 sec minimum :-(
    click_on 'Edit client'

    within '#clients-list' do
      expect(page).to have_content client_data.email
    end
  end

  describe 'does not update client' do
    context 'with wrong fullname:' do
      scenario 'when missing letters' do
        fill_in 'Client full name', with: 'abc'
        fill_in 'Client phone number', with: client_data.phone

        expect(page).to have_content 'Please use mimimum 5 characters'
        expect(page).to have_button 'Edit client', disabled: true
      end

      scenario 'when digits in fullname' do
        fill_in 'Client full name', with: '78946513'
        fill_in 'Client phone number', with: client_data.phone

        expect(page).to have_content 'Only letters are allowed'
        expect(page).to have_button 'Edit client', disabled: true
      end
    end

    context 'with wrong phone:' do
      scenario 'when letters in input' do
        fill_in 'Client phone number', with: 'abc'
        fill_in 'Client full name', with: client_data.fullname

        expect(page).to have_content 'Field is required'
        expect(page).to have_button 'Edit client', disabled: true
      end

      scenario 'when missing digits' do
        fill_in 'Client phone number', with: '1324654'
        fill_in 'Client full name', with: client_data.fullname

        expect(page).to have_content 'Please use 10 digits'
        expect(page).to have_button 'Edit client', disabled: true
      end
    end

    context 'with wrong email:' do
      scenario 'when incorrect email' do
        fill_in 'Client email', with: 'mail@ru'
        fill_in 'Client full name', with: client_data.fullname

        expect(page).to have_content 'Enter correct email'
        expect(page).to have_button 'Edit client', disabled: true
      end
    end
  end
end
