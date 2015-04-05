class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  load_and_authorize_resource
  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.advert = Advert.find(params[:advert_id])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.advert, notice: 'Comment was successfully created.' }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment.advert, notice: 'Comment was successfully updated.' }
      else
        format.html { redirect_to @comment.advert, alert: 'Nope' }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
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
