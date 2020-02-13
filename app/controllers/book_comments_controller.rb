class BookCommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_correct_user, {only: [:destroy]}
  def create
  	@book = Book.find(params[:book_id])
  	@comment = BookComment.new(book_comment_params)
  	@comment.user_id = current_user.id
  	@comment.book_id = @book.id
  	if @comment.save
      @book_new = Book.new
      @book_comment = BookComment.new
      @user = User.find_by(id: @book.user_id)
  	   render 'books/show'
    else
       flash[:danger] = 'コメントの投稿に失敗しました'
       redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @comment = BookComment.find_by(id: params[:id],book_id: params[:book_id])
    @comment.destroy
    @book = Book.find(params[:book_id])
    @book_new = Book.new
    @book_comment = BookComment.new
    @user = User.find_by(id: @book.user_id)
    render 'books/show'
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

