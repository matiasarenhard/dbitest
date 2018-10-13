class Api::V1::QuoteSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quote, :author, :author_about, :tags

  attribute :id do |object|
    object.id.to_s
  end
end
