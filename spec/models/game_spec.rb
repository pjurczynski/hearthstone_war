require 'rails_helper'

describe Game do
  it { is_expected.to validate_presence_of :player_1 }
  it { is_expected.to validate_presence_of :player_2 }
end
