require 'rails_helper'

RSpec.describe Person, type: :model do
  it { should have_many(:messages).dependent(:destroy) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
end
