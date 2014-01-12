class Work
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String
  field :asset_filename, type: String
  mount_uploader :cover, PictureUploader
  validates_presence_of :name
  validates_presence_of :description
  default_scope order_by(:created_at => :desc)
end
