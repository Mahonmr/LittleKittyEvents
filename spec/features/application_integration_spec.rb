require 'rails_helper'

describe 'Signing up' do
  it 'Guides you through signing-up' do
    visit root_path
    click_link 'Sign up'
    fill_in 'Email', with: 'lk@me.com'
    fill_in 'First name', with: 'Little'
    fill_in 'Last name', with: 'Kitty'
    fill_in 'Password', with: 'melittleKitty'
    fill_in 'Password confirmation', with: 'melittleKitty'
    click_button 'Sign up'
    expect(current_path).to eq(root_path)
    expect(page).to have_content("Logged in as Little Kitty")
  end

  it 'gives an error message when the email is missing' do
    visit root_path
    click_link 'Sign up'
    fill_in 'First name', with: 'Little'
    fill_in 'Last name', with: 'Kitty'
    fill_in 'Password', with: 'melittleKitty'
    fill_in 'Password confirmation', with: 'melittleKitty'
    click_button 'Sign up'
    expect(page).to have_content('error')
  end

  it 'gives an error message when the First Name is missing' do
    visit root_path
    click_link 'Sign up'
    fill_in 'Email', with: 'lk@me.com'
    fill_in 'Last name', with: 'Kitty'
    fill_in 'Password', with: 'melittleKitty'
    fill_in 'Password confirmation', with: 'melittleKitty'
    click_button 'Sign up'
    expect(page).to have_content('error')
  end

  it 'gives an error message when the Last Name is missing' do
    visit root_path
    click_link 'Sign up'
    fill_in 'Email', with: 'lk@me.com'
    fill_in 'First name', with: 'Kitty'
    fill_in 'Password', with: 'melittleKitty'
    fill_in 'Password confirmation', with: 'melittleKitty'
    click_button 'Sign up'
    expect(page).to have_content('error')
  end
end
