require 'rails_helper'

RSpec.describe User, type: :model do

  # Validate Attributes
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }

  # Validate the relationship
  it { should have_many(:notes) }

end