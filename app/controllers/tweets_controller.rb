class TweetsController < ApplicationController
#-----コールバックモジュール--------------------
  before_action :set_tweet, only: [:edit, :show]         
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
    #query = "SELECT * FROM tweets"
    #@tweets = Tweet.find_by_sql(query)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    # binding.pry
    Tweet.create(tweet_params)
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
  end

  def show
    #@tweet = Tweet.find(params[:id])
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end




  def search
  # @tweets = SearchTweetsService.search(params[:keyword])
   # @tweets = Tweet.search(params[:keyword])
   
      # キーワード分割
      keywords = params[:keyword].split(/[[:blank:]]+/).select(&:present?)
      binding.pry
      # 空のモデルオブジェクト作成（何も入っていない空配列のようなもの）
      @tweets = Tweet.none

      # 検索ワードの数だけor検索を行う
      keywords.each do |keyword|
        binding.pry
        #keyword = keyword.tr('〇一二三四五六七八九', '0123456789').gsub(/(\d+)?十(\d+)?/) { ($1 || 1).to_i * 10 + $2.to_i }
        @tweets = @tweets.or(Tweet.where("text LIKE ?", "%#{keyword}%"))
      end

        #YaKansuji.to_kan(keyword)
        
        #YaKansuji.to_i("三") # => 3
  end







  private
  def tweet_params
    params.require(:tweet).permit(:image, :text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
   
  #ログインしてないとトップページに戻る
  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end

