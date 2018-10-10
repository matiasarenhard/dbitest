class User
  include Mongoid::Document
  field :name, type: String
  field :api_key, type: String
  validates_presence_of :name, :api_key
end
