class EventType < ActiveRecord::Base
  validates :name, :event_type, :type_url, presence: true
  validates :name, uniqueness: true
end
