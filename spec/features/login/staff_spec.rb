# frozen_string_literal: true

require 'rails_helper'

feature 'Staff can sign in' do
  given(:staff) { create(:staff) }
  given(:client) { create(:client) }

  background { visit new_staff_session_path }

  scenario 'Registered as staff user tries to sign in', js: true do
    sign_in(staff)

    expect(page).to have_content "Welcome, #{staff.email}"
    expect(page).to have_content 'Staff component'
  end

  scenario 'Unregistered user tries to sign in' do
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end

  scenario 'Client tries to sign in as staff' do
    sign_in(client)

    expect(page).to have_content 'Invalid Email or password.'
    expect(page).to_not have_content "Welcome, #{client.email}"
  end
end

feature 'Staff can sign out', "
  As an authenticated staff user
  I'd like to be able to sign out
" do
  given(:staff) { create(:staff) }

  background { visit new_staff_session_path }

  scenario 'Registered as staff user tries to sign out', js: true do
    sign_in(staff)
    click_on 'Logout'

    expect(page).to_not have_content "Welcome, #{staff.email}"
    expect(page).to have_link 'Staff Login'
    expect(current_path).to eq root_path
  end
end
