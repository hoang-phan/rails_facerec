require 'rails_helper'

describe ImagesController, type: :controller do
  describe 'GET index' do
    it 'returns all images' do
      get :index
      expect(assigns(:images).to_sql).to eq Image.all.to_sql
    end
  end

  describe 'POST create' do
    let(:params) do
      {
        image: {
          binary_data: data
        }
      }
    end

    let(:data) { 'my_data' }

    context 'image saved successfully' do
      let(:image) { Image.last }

      it 'returns success' do
        expect(Recognizer).to receive(:perform_async)
        expect {
          post :create, params
        }.to change(Image, :count).by(1)
        expect(response).to be_success
        expect(image.binary_data).to eq data
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

  describe 'PUT update' do
    let(:params) do
      {
        image: {
          person_name: person_name
        },
        id: image.id
      }
    end

    let(:person_name) { 'John Doe' }
    let!(:image) { create(:image) }

    it 'updates image' do
      expect {
        put :update, params
      }.to change {
        image.reload.person_name
      }.to(person_name)

      expect(response).to redirect_to(images_path)
    end
  end

  describe 'DELETE destroy' do
    let(:params) do
      {
        id: image.id
      }
    end

    let!(:image) { create(:image) }

    it 'updates image' do
      expect {
        delete :destroy, params
      }.to change(Image, :count).by(-1)

      expect(response).to redirect_to(images_path)
    end
  end
end
