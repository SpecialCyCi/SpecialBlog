class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]

  def index
    @articles = Article.paginate(:page => params[:page], :per_page => 5)
  end

  def show
    @comments = @article.comments.paginate(:page => params[:c_page], :per_page => 5)
    respond_to do |format|
      format.js { render :ajax_comments }
      format.html
    end
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

end
