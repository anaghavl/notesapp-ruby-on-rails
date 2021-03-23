require 'rails_helper'

RSpec.describe Note, type: :model do

  # Validate Attributes
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
  it { is_expected.to validate_presence_of :tag }

  # Validate the relationship
  it { should belong_to(:user) }
end