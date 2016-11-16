class Website < ApplicationRecord
  has_many :contents, dependent: :destroy
end
