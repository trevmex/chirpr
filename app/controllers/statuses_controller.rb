class StatusesController < ApplicationController
  def index
    @statuses = Status.all
  end

  def show
    @status = Status.find(params[:id])
  end

  def new
    @status = Status.new
  end

  def create
    @user = User.find(params[:user_id] || params[:status][:user_id])
    @status = @user.statuses.create(params[:status])
    redirect_to user_path(@user)
  end

  def edit
    @status = Status.find(params[:id])
  end

  def update
    @status = Status.find(params[:id])
    @status.update_attributes(params[:status])
    redirect_to status_path(@status)
  end

  # DELETE /statuses/1
  def destroy
    @status = Status.find(params[:id])
    @status.destroy
    flash[:notice] = "Status was deleted."
    redirect_to statuses_path
  end
end
