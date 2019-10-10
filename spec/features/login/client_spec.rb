# frozen_string_literal: true

require 'rails_helper'

feature 'Client can sign in' do
  given(:client) { create :client }
  given(:staff) { create :staff }

  background { visit new_client_session_path }

  scenario 'Registered as client user tries to sign in', js: true do
    sign_in(client)

    expect(page).to have_content "Welcome, #{client.email}"
    expect(page).to have_content 'Client component'
  end

  scenario 'Unregistered user tries to sign in' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end

  scenario 'Staff tries to sign in as client' do
    sign_in(staff)

    expect(page).to have_content 'Invalid Email or password.'
    expect(page).to_not have_content "Welcome, #{staff.email}"
  end
end

feature 'Client can sign out', "
  As an authenticated client user
  I'd like to be able to sign out
" do
  given(:client) { create(:client) }

  background { visit new_client_session_path }

  scenario 'Registered as client user tries to sign out', js: true do
    sign_in(client)
    click_on 'Logout'

    expect(page).to_not have_content "Welcome, #{client.email}"
    expect(page).to have_link 'Client Login'
    expect(current_path).to eq root_path
  end
end
