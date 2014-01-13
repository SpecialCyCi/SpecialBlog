class Setting
  include Mongoid::Document
  field :key, type: String
  field :value, type: String

  def self.set name, value
    Setting.find_or_create_by({:key => name, :value => value})
  end

  def self.get name
    Setting.where({:key => name}).first.value
  end
end
