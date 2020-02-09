class BookCommentsController < ApplicationController
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
    @book = Book.find(params[:book_id])
    @comment = BookComment.find(params[:book_id])
    @comment.destroy
    redirect_to book_path(@book)

  private
   def book_comment_params
   		params.require(:book_comment).permit(:user_id,:book_id,:comment)
   end
end
