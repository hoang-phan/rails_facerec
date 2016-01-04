class ImagesController < ApplicationController
  def index
    @images = Image.all
  end

  def create
    if image.save
      render json: { message: 'Success' }
    else
      render json: { errors: image.errors.full_messages.join('. ') }, status: :unprocessable_entity
    end
  end

  private

  def image
    @image ||= Image.new(image_params)
  end

  def image_params
    params.require(:image).permit(:binary_data)
  end
end
