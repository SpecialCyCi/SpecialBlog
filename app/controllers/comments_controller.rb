class CommentsController < ApplicationController
  before_filter :find_commentable

  def index
    @comments = @commentable.comments
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comment.save
    if @comment.save
      flash[:notice] = "Thank your comment."
    else
      flash[:notice] = @comment.errors.full_messages.first
    end
    redirect_to polymorphic_url(@commentable, nickname: @comment.nickname, content: @comment.content)
  end
  
  private
    def find_commentable
      params.each do |name, value|
        @commentable =  $1.classify.constantize.find(value) if name =~ /(.+)_id$/
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:nickname, :content)
    end
end
