class SearchesController < ApplicationController
 def index
 	if params[:list] == "Book"
 	  @books = Book.search(params[:search],params[:search_method])
 elsif params[:list] == "User"
 	  @users = User.search(params[:search],params[:search_method])
    end
 end
end
