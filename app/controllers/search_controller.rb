class SearchController < ApplicationController
  def index
    @posts = Post.search(title_cont: params[:q]).result
  end
end
