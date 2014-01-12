class Setting
  include Mongoid::Document
  field :key, type: String
  field :value, type: String

  def self.get name
    Setting.where({:key => name}).first.value
  end
end
