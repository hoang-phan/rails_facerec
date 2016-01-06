class Image < ActiveRecord::Base
  scope :classified, -> { where.not(person_name: nil) }
end
