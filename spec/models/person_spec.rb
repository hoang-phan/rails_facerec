require 'rails_helper'

describe Person, type: :model do
  it { is_expected.to have_many(:images) }
end
