class BlogController < ApplicationController

  def starter
    @statement = Statement.order(rank: :asc).last
    render :starter, :layout=> false
  end
  
  def view_next
    @statement = Statement.order(rank: :asc).where(["rank > ?", params[:rank].to_i]).first
    render :starter, :layout=> false
  end
  
  def view_prev
    @statement = Statement.order(rank: :asc).where(["rank < ?", params[:rank].to_i]).last
    render :starter, :layout=> false
  end
  
  def conversation
    @statement = Statement.find params[:id]
    unless @statement.parent.nil?
      @statement = @statement.parent
    end
  end
  
  def delete
    if params[:k]=="delete"
      @statement = Statement.find params[:id]
      @statement.destroy
    end
    render :json => {:ok=>1}
  end

  def save
    statement = Statement.create(title:params[:title],body:params[:body],user:@user, parent_id:params[:parent_id])
    if params[:parent_id].present?
      redirect_to "/rebuttal/#{params[:parent_id]}"
    else
      redirect_to "/"
    end
    
  end

end
