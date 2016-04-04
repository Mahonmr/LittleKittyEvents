require 'rails_helper'


describe 'User who is not signed it' do

  it 'Will allow visitors to view clubs' do
    visit clubs_path
    expect(page).to have_content('Listing Clubs')
  end
end

describe 'Admin Permission' do
  let!(:user)  { create(:user) }

  it 'Will not allow you in admin if not admin' do
    sign_in_user(user)
    visit admin_clubs_path
    expect(page).to have_content('That is very naughty!')
  end
end

describe 'club index' do
  let!(:user)  { create(:user, :with_club) }
  let!(:user2) { create(:user, :admin)}

  it 'Show all clubs' do
    sign_in_user(user)
    click_link 'Clubs'
    expect(page).to have_content('Little Kitty Club')
  end

  it 'Shows manager of club in the admin index' do
    sign_in_user(user2)
    click_link 'Clubs'
    expect(page).to have_content('Little Kitty')
  end
end

describe 'creating a club' do
  let!(:user)    { create(:user) }

  it 'creates a club when all required fields are filled in' do
    sign_in_user(user)
    click_link 'Clubs'
    click_link 'New Club'
    fill_in 'club_name', with: 'test club'
    fill_in 'club_location', with: 'test location'
    click_button 'Create Club'
    expect(page).to have_content('test club')
    expect(current_path).to eq athlete_clubs_path
  end

  it 'gives an error message when the required fields are missing' do
    sign_in_user(user)
    visit new_club_path
    click_button 'Create Club'
    expect(page).to have_content('error')
  end
end

describe 'editing an club' do
  let!(:user)    { create(:user, :with_club) }

  it 'allows you to edit a club' do
    sign_in_user(user)
    click_link 'Clubs'
    expect(page).to have_content '1234 SW Kitty Cat Ln, Portland OR'
    click_link 'Edit'
    fill_in 'club_location', with: 'new location'
    click_button 'Update Club'
    expect(current_path).to eq athlete_clubs_path
    expect(page).to have_content 'new location'
  end

  it 'gives an error message when requried fields are missing' do
    sign_in_user(user)
    visit athlete_clubs_path
    click_link 'Edit'
    fill_in 'club_location', with: ' '
    click_button 'Update Club'
    expect(page).to have_content('error')
  end
end

describe 'deleting a club' do
  let!(:user)    { create(:user, :with_club) }

  it 'allows you to delete a club' do
    sign_in_user(user)
    visit athlete_clubs_path
    click_link 'Destroy'
    expect(current_path).to eq athlete_clubs_path
    expect(page).to have_content 'Club was successfully deleted'
  end
end

describe 'Joining a club' do
  let!(:user)    { create(:user, :with_club) }
  let!(:user2)    { create(:user) }

  it 'allows athlete to join club' do
    sign_in_user(user2)
    visit athlete_clubs_path
    click_link 'Add'
    expect(current_path).to eq athlete_clubs_path
    expect(page).to have_content "You have successfully joined #{user2.clubs.last.name}"
  end
end

def sign_in_user(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
  end
