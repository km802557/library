class AuthorsController < ApplicationController
 before_filter :signed_in_author, only: [:index, :edit, :update]
 before_filter :correct_author,   only: [:edit, :update]
  before_filter :admin_author,     only: :destroy

 
 def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end
  
  
  def create
    @author = Author.new(params[:author])
    if @author.save
      redirect_to @author
    else
      render 'new'
    end
  end
  
  def edit
    @author = Author.find(params[:id])
  end
  
  def update
    @author= Author.find(params[:id])
    if @author.update_attributes(params[:author])
      flash[:success] = "Profile updated"
      sign_in @author
      redirect_to @author
    else
      render 'edit'
    end
  end
  
  def destroy
    Author.find(params[:id]).destroy
    flash[:success] = "Author destroyed."
    redirect_to authors_url
  end
  
  def index
	  @authors =  Author.all
  end
  
  def show
    @author = Author.find(params[:id])
    @publications = @author.publications.paginate(page: params[:page])
  end
  
  
  def admin_user
      redirect_to(root_path) unless current_author.admin?
    end
    
end