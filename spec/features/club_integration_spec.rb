require 'rails_helper'


describe 'club index' do
  let!(:club) { create :club }

  it 'Show all clubs' do
    visit root_path
    expect(page).to have_content('Little Kitty Club')
  end
end

describe 'creating an club' do

  it 'creates a club when all required fields are filled in' do
    visit root_path
    click_link 'New Club'
    fill_in 'club_name', with: 'test club'
    fill_in 'club_location', with: 'test location'
    click_button 'Create Club'
    expect(page).to have_content('test club')
    expect(current_path).to eq clubs_path
  end

  it 'gives an error message when the required fields are missing' do
    visit new_club_path
    click_button 'Create Club'
    expect(page).to have_content('error')
  end
end

describe 'editing an club' do
  let!(:club) { create :club }

  it 'allows you to edit a club' do
    visit root_path
    expect(page).to have_content '1234 SW Kitty Cat Ln, Portland OR'
    click_link 'Edit'
    fill_in 'club_location', with: 'new location'
    click_button 'Update Club'
    expect(current_path).to eq clubs_path
    expect(page).to have_content 'new location'
  end
end

  describe 'deleting a club' do
  let!(:club) { create :club }

  it 'allows you to delete a club a club' do
    visit root_path
    click_link 'Destroy'
    expect(current_path).to eq clubs_path
    expect(page).to have_content 'Club was successfully destroyed'
  end
end
