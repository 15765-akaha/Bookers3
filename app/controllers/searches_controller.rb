class SearchesController < ApplicationController
 def index
 	if params[:list] == "Book"
 	  @books = Book.search(params[:search])
 elsif params[:list] == "User"
 	  @users = User.search(params[:search])
    end
 end
end
