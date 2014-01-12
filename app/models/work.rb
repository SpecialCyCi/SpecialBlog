class Work
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :description, type: String
  field :asset_filename, type: String
  field :visit_count, type: Integer, default: 0
  mount_uploader :cover, PictureUploader
  has_many :pictures
  validates_presence_of :name
  validates_presence_of :description
  default_scope order_by(:created_at => :desc)
end
