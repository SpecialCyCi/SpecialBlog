class Links
  include Mongoid::Document
  field :name, type: String
  field :logo, type: String
  field :url, type: String
  validates_presence_of :name
  validates_presence_of :url
end
