class GcmsController < ApplicationController
  def create
    Device.create(register_id: params[:key])
    render nothing: true
  end
end