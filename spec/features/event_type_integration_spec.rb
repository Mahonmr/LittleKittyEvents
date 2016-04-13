require 'rails_helper'

feature 'User access' do
  let!(:user)    { create(:user) }
  let!(:admin)    { create(:user, :admin)}
  let!(:user2)    { create(:user) }

  context 'Users index' do
    it 'will not allow athletes to view event types' do
      sign_in_user(user)
      visit admin_event_types_path
      expect(page).to have_content('Access denied!')
    end

    it 'will allow admin to view user index' do
      sign_in_user(admin)
      visit admin_event_types_path
      expect(page).to have_content('Listing Event Types')
    end
  end

  context 'Create Event Type' do
    it 'will allow admin to create event type' do
      sign_in_user(admin)
      visit admin_event_types_path
      click_link 'New Event Type'
      fill_in 'Name', with: 'Event Type Name'
      fill_in 'Event type', with: 'Test Type'
      fill_in 'Sub type', with: 'Test Sub Type'
      fill_in 'Type url', with: 'Test url'
      click_button 'Create Event type'
      expect(current_path).to eq admin_event_types_path
      expect(page).to have_content('Event Type Created')
    end
  end

  context 'Allows Admin to Edit/Delete Event Type' do
    let!(:event_type) { create(:event_type) }

    it 'allows admin to edit a event_type' do
      sign_in_user(admin)
      visit edit_event_type_path(event_type)
      fill_in 'Name', with: 'Testing Edit'
      click_button 'Update Event type'
      expect(current_path).to eq admin_event_types_path
      expect(page).to have_content 'Testing Edit'
    end

    it 'allows admin to delete a event_type' do
      sign_in_user(admin)
      visit admin_event_types_path
      click_link 'Delete'
      expect(current_path).to eq admin_event_types_path
      expect(page).to have_content 'Event Type Deleted'
    end
  end
end
