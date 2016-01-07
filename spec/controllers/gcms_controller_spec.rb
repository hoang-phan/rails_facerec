require 'rails_helper'

describe GcmsController, type: :controller do
  describe 'POST create' do
    let(:reg_id) { 'reg_id' }
    let(:params) { { key: reg_id } }
    let(:device) { Device.last }

    it 'creates new device' do
      expect {
        post :create, params
      }.to change(Device, :count).by(1)
      expect(device.register_id).to eq reg_id
    end
  end
end
