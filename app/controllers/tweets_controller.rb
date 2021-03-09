class TweetsController < ApplicationController
#-----コールバックモジュール--------------------
  before_action :set_tweet, only: [:edit, :show]         
  before_action :move_to_index, except: [:index, :show, :search]

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
  end

  def new
    @tweet = Tweet.new
  end

  def create
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
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  def search
      # キーワード分割
      keywords = params[:keyword].split(/[[:blank:]]+/).select(&:present?)
      # 空のモデルオブジェクト作成（何も入っていない空配列のようなもの）
      @tweets = Tweet.none

      # 検索ワードの数だけor検索を行う
      keywords.each do |keyword|
        @tweets = @tweets.or(Tweet.where("text LIKE ?", "%#{keyword}%"))
      end
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

