class BlogController < ApplicationController

  def index
    @statement = Statement.order(rank: :asc).last
  end
  
  def view_next
    @statement = Statement.order(rank: :asc).where(["rank > ?", params[:rank].to_i]).first
    render :index, :layout=> false
  end
  
  def view_prev
    @statement = Statement.order(rank: :asc).where(["rank < ?", params[:rank].to_i]).last
    render :index, :layout=> false
  end

  def save
    statement = Statement.create(title:params[:title],body:params[:body],user:@user)
    redirect_to "/"
  end

end
