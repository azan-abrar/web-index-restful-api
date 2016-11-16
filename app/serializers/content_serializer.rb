class ContentSerializer < ActiveModel::Serializer
  attributes :id, :content_type, :content_text

  belongs_to :website
end
