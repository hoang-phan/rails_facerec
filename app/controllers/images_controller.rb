class ImagesController < ApplicationController
  before_action :set_image, only: [:update, :destroy]

  def index
    @images = Image.all
  end

  def create
    if image.save
      Recognizer.perform_async(image.id)
      render json: { message: 'Success' }
    else
      render json: { errors: image.errors.full_messages.join('. ') }, status: :unprocessable_entity
    end
  end

  def update
    @image.update_attributes(image_params)
    redirect_to images_path
  end

  def destroy
    @image.destroy
    redirect_to images_path
  end

  private

  def set_image
    @image = Image.find(params[:id])
  end

  def image
    @image ||= Image.new(image_params)
  end

  def image_params
    params.require(:image).permit(:binary_data, :person_name)
  end
end
