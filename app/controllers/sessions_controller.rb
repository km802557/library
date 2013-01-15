class SessionsController < ApplicationController

  def new
  end

  def create
    author = Author.find_by_nickname(params[:session][:nickname])
    if author && author.authenticate(params[:session][:password])
      sign_in author
      redirect_back_or author
    else
      flash.now[:error] = 'Invalid nickname/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
