class Person < ApplicationRecord
  has_many :messages, dependent: :destroy

  validates_presence_of :first_name, :last_name, :email
end
