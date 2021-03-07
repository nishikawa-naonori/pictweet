class UsersController < ApplicationController
  def show
    # binding.pry
    user = User.find(params[:id])
    @nickname = user.nickname
    @tweets = user.tweets
  end
end