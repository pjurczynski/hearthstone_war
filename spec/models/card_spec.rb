require 'rails_helper'

describe Card do
  it { is_expected.to belong_to :deck }
end
