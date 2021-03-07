class SearchTweetsService
  def self.search(search)
    if search != ""
      search = "%#{search}%"
      search1 = "%#{search}%"

      Tweet.find_by_sql(["select * from tweets 
                          where 
                          text like ? ", search]) 
      #    likeで文字列で使うから "%#{search}%"をやってる  任意の文字は？    
      #    like ?   ユーザーの入力を適用する前にSQL文を確定  悪意のあるユーザーのSQLのハッキングを防ぐ
    else
      Tweet.order('created_at DESC')
    end
  end
end

# SELECT * 
# FROM articles 
# WHERE 
# (name like '%A%' or description like '%A%')
# AND 
# (name like '%B%' or description like '%B%')