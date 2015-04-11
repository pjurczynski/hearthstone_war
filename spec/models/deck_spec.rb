require 'rails_helper'

describe Deck do
  it { is_expected.to have_many :cards }
end
