  class TweetsController < ApplicationController

    before_action  :except => [:index]

    def index
      @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    end

    def show
      @tweet = Tweet.find(params[:id])
      @comments =@tweet.comments.includes(:user)
    end

    def new
    end

    def create
      Tweet.create(image: tweet_params[:image], text: tweet_params[:text], user_id: current_user.id)
    end

    def destroy
      tweet.destroy if tweet_url == current_user.id
    end

    def edit
      @tweet =Tweet.find(id_params[:id])
    end

    def update
      tweet = Tweet.find(id_params[:id])
      tweet.update(tweet_params) if tweet.id == current_user.id
    end

    private
    def tweet_params
      params.permit(:name, :image, :text)
    end

    def id_params
      params.permit(:id)
    end

    def rederect_index
      rederect_index :action => "index" unless user_signed_in?
    end
  end
