class SearchesController < ApplicationController
 def index
 	@books = Book.search(params[:search])
 	@users = User.search(params[:search])
 end
end
