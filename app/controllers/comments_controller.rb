class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  load_and_authorize_resource

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.advert = Advert.find(params[:advert_id])
      if @comment.save
        render  :partial => "comments/comment",
                :locals => { :@advert => @comment.advert, :comment  => @comment}, :layout => false,
                :status => :created
      end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.advert, notice: 'Comment was successfully updated.' }
        format.json { respond_with_bip(@comment) }
      else
        format.html { redirect_to @comment.advert, alert: 'Nope' }
        format.json { respond_with_bip(@comment) }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js { render :nothing => true }
      format.html { redirect_to @comment.advert, notice: "Comment added" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body)
    end
end
