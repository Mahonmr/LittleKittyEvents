require 'rails_helper'

feature 'User access' do
  let!(:user)    { create(:user) }
  let!(:admin)    { create(:user, :admin)}
  let!(:user2)    { create(:user) }

  context 'Users index' do
    it 'will not allow athletes to view user index' do
      sign_in_user(user)
      visit admin_users_path
      expect(page).to have_content('That is very naughty!')
    end

    it 'will allow admin to view user index' do
      sign_in_user(admin)
      visit admin_users_path
      expect(page).to have_content('Admin List of Users')
    end

    it 'will allow athletes to view other athletes' do
      sign_in_user(user)
      visit athlete_users_path
      expect(page).to have_content('Athletes')
    end
  end

  context 'Edit User and Show User' do
    it 'will allow Admin to edit someones profile' do
      sign_in_user(admin)
      visit admin_users_path
      visit edit_admin_user_path(user)
      fill_in 'Last name', with: 'Mahoney'
      click_button 'Update User'
      expect(page).to have_content('User was successfully updated')
    end

    it 'will allow athlete to edit their profile' do
      sign_in_user(user)
      click_link 'Me'
      fill_in 'Last name', with: 'Mahoney'
      click_button 'Update User'
      expect(page).to have_content('User was successfully updated')
    end

    it 'will not allow user to edit another profile' do
      sign_in_user(user)
      visit edit_athlete_user_path(user2)
      expect(page).to have_content('Access denied!')
    end

    it 'will not allow user to edit another profile' do
      sign_in_user(user)
      visit athlete_user_path(user2)
      expect(page).to have_content('Show Athlete')
    end
  end

  def sign_in_user(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
end
