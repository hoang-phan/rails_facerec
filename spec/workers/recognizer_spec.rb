require 'rails_helper'

describe Recognizer do
  describe '#perform' do
    let(:sample_image) { create(:image) }
    let(:test_image) { create(:image, person_name: nil) }

    it 'recognizes correct model' do
      expect(subject).to receive(:send_push_messages).with(sample_image.id)
      subject.perform(sample_image.id)
    end
  end
end
