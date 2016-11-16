class WebsiteSerializer < ActiveModel::Serializer
  attributes :id, :url

  has_many :contents
end
