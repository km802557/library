class StaticPagesController < ApplicationController

 def home
    if signed_in?
    @publication = current_author.publications.build 
    #~ @feed_items = current_author.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

end
