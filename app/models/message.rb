class Message < ApplicationRecord
  belongs_to :person

  validates_presence_of :message_body
end
