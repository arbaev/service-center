# frozen_string_literal: true

require 'rails_helper'

feature 'When user sign in as Staff', js: true do
  given(:staff) { create(:staff) }

  background do
    visit root_path
    click_on 'Staff Login'
    sign_in staff
  end

  scenario 'his email is shown in welcome message' do
    within '#header-main' do
      expect(page).to have_content "Welcome, #{staff.email}!"
      expect(page).to have_link 'Logout'
    end
  end

  scenario 'he can sign out' do
    within '#header-main' do
      expect(page).to have_content "Welcome, #{staff.email}!"

      click_on 'Logout'

      expect(page).to_not have_content "Welcome, #{staff.email}!"
      expect(page).to have_link 'Staff Login'
    end
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_current_path(root_path)
  end
end

feature 'When user sign in as Client', js: true do
  given(:client) { create(:client) }

  background do
    visit root_path
    click_on 'Client Login'
    sign_in client
  end

  scenario 'his email is shown in welcome message' do
    within '#header-main' do
      expect(page).to have_content "Welcome, #{client.email}!"
      expect(page).to have_link 'Logout'
    end
  end

  scenario 'he can sign out' do
    within '#header-main' do
      expect(page).to have_content "Welcome, #{client.email}!"

      click_on 'Logout'

      expect(page).to_not have_content "Welcome, #{client.email}!"
      expect(page).to have_link 'Client Login'
    end
    expect(page).to have_content 'Signed out successfully.'
    expect(page).to have_current_path(root_path)
  end
end
