require 'opencv'

class RecognizesController < ApplicationController
  def create
    test_image = OpenCV::CvMat.decode_image(params[:data], OpenCV::CV_LOAD_IMAGE_GRAYSCALE)
    samples, labels = [], []
    Image.find_each do |image|
      samples << OpenCV::CvMat.decode_image(image.binary_data, OpenCV::CV_LOAD_IMAGE_GRAYSCALE)
      labels << image.person_id
    end
    m = OpenCV::EigenFaces.new
    m.train(samples, labels)
    person_id = m.predict(test_image)[0]
    render json: { name: Person.find(person_id).name }
  end
end
