class CommentsController < ApplicationController
 



    def create
      @comment = Comment.new(comment_params)
      if @comment.save
        redirect_to prototype_path(@comment.prototype)
      else
        @prototype = @comment.prototype
        @comments = @prototype.comments
        render "prototypes/show" # ファイルパスを正しく指定する必要があります。
      end
    end
  
    private
    def comment_params
      params.require(:comment).permit(:content).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    end
  
end

