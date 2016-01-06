require 'opencv'

class Recognizer
  include Sidekiq::Worker
  include OpenCV

  def perform(image_id)
    image = Image.find_by_id(image_id)
    if image && Image.classified.exists?
      analyzer = EigenFaces.new
      analyzer.train(*build_samples)
      id, confidence = analyzer.predict(CvMat.decode_image(image.binary_data, CV_LOAD_IMAGE_GRAYSCALE))
      send_push_messages(id)
    end
  end

  def send_push_messages(image_id)
  end

  def build_samples
    samples, labels = [], []
    Image.classified.find_each do |image|
      samples << CvMat.decode_image(image.binary_data, CV_LOAD_IMAGE_GRAYSCALE)
      labels << image.id
    end

    [samples, labels]
  end
end