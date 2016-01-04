require 'rails_helper'

describe TrainsController, type: :controller do
  describe 'POST create' do
    let(:params) do
      {
        name: person_name,
        data: data
      }
    end

    let(:person_name) { 'John Doe' }
    let(:data) { 'my_data' }

    context 'image saved successfully' do
      let(:image) { Image.last }
      let(:person) { Person.last }

      it 'returns success' do
        expect {
          post :create, params
        }.to change(Image, :count).by(1)
          .and change(Person, :count).by(1)
        expect(response).to be_success
        expect(image.binary_data).to eq data
        expect(image.person).to eq person
      end
    end

    context 'image failed to create' do
      let(:errors) { double(full_messages: ['a', 'b', 'c'] ) }
      let(:json) { JSON(response.body) }

      before do
        allow_any_instance_of(Image).to receive(:save).and_return(false)
        allow_any_instance_of(Image).to receive(:errors).and_return(errors)
      end

      it 'returns failures' do
        expect {
          post :create, params
        }.not_to change(Image, :count)
        expect(response).to be_unprocessable
        expect(json['errors']).to eq 'a. b. c'
      end
    end
  end
end
