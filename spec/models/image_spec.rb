require 'rails_helper'

describe Image, type: :model do
  describe '.classified' do
    it { expect(described_class.classified.to_sql).to eq described_class.where.not(person_name: nil).to_sql }
  end
end
