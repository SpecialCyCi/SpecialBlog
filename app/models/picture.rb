class Picture
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :article
  mount_uploader :asset, PictureUploader
  field :url, type: String
  before_save :set_url

  def set_url
    self.url = asset.url
    true
  end
end
