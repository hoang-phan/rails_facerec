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

  describe '#send_push_messages' do
    let!(:image) { create(:image, binary_data: data) }
    let(:data) { 'data' }

    it 'sends image data to devices' do
      expect($gcm).to receive(:send).with(
        Device.pluck(:register_id), 
        {
          data: {
            data: data
          },
          collapse_key: image.person_name
        }
      )
      subject.send_push_messages(image.id)
    end
  end
end
