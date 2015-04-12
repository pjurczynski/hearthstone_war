require 'rails_helper'

describe Player do
  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :available_cards }
end
