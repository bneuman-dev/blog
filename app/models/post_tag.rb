class PostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :tag
  validates :tag, uniqueness: { scope: :post }
  # Remember to create a migration!
end
