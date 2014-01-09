class Comment
  include Mongoid::Document
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::CounterCache
  field :nickname, type: String
  field :content, type: String
  belongs_to :commentable, polymorphic: true
  index :commentable_type => 1
  index :commentable_id => 1
  counter_cache name: :commentable, inverse_of: :comments
  validates_presence_of :content
  validates_presence_of :nickname

  def commentable
    commentable_type.classify.constantize.find(commentable_id)
  end
end
