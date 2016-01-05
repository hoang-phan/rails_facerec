require 'spec_helper'

describe RecognizesController, type: :controller do
  describe 'POST create' do
    let(:params) do
      {
        data: data
      }
    end

    let(:image) { create(:image, person: person) }
    let(:person) { create(:person) }
    let(:json) { JSON(response.body) }
    let(:data) { image.binary_data }

    it 'returns person\'s name' do
      post :create, params
      expect(response).to be_success
      expect(json['name']).to eq person.name
    end
  end
end
