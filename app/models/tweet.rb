class Tweet < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments
end

# textカラムから#{search}が入っているレコードを全て取得


# def self.search(search)
#   if search != ""
#    Tweet.where('text LIKE(?)', "%#{search}%")
#   else
#     Tweet.all
#   end
# end