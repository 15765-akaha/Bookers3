class BookCommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, {only: [:destroy]}
  def create
  	@book = Book.find(params[:book_id])
  	@comment = BookComment.new(book_comment_params)
  	@comment.user_id = current_user.id
  	@comment.book_id = @book.id
  	if @comment.save
  	   redirect_back(fallback_location: root_path)
    else
       redirect_to book_path(@book)
    end
  end

  def destroy
    comment = BookComment.find_by(id: params[:id],book_id: params[:book_id])
    comment.destroy
    redirect_to book_path(params[:book_id])
    # インスタンス変数だと通らなかった。
  end

  private
   def book_comment_params
   		params.require(:book_comment).permit(:user_id,:book_id,:comment)
   end
   def ensure_correct_user
    @comment = BookComment.find(params[:id])
    if current_user.id != @comment.user_id
       redirect_to books_path
    end
  end
end

