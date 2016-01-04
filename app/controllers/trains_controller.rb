class TrainsController < ApplicationController
  def create
    if image.save
      render json: { message: 'Success' }
    else
      render json: { errors: image.errors.full_messages.join('. ') }, status: :unprocessable_entity
    end
  end

  private

  def person
    @person ||= Person.find_or_create_by(name: params[:name])
  end

  def image
    @image ||= Image.new(binary_data: params[:data], person: person)
  end
end
