require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to(:person) }

  it { should validate_presence_of(:message_body) }
end
