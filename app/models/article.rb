class Article
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :content, type: String
  field :comments_count, type: Integer, default: 0
  field :visit_count, type: Integer, default: 0
  has_many :comments, as: :commentable
  has_many :pictures
  belongs_to :category
  validates_presence_of :category
  validates_presence_of :title
  validates_presence_of :content

  default_scope order_by(:created_at => :desc)
end
