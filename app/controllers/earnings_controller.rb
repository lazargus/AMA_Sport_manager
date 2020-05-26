class EarningsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_earning, only: [ :show, :edit, :update, :destroy ]

  def index
    @earnings = Earning.all
  end

  def show; end

  def new
    @earning = Earning.new
  end

  def create
    @earning = Earning.new(earning_params)
    @earning.user = current_user
    if @earning.save
      redirect_to earning_path(@earning)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @earning.update(earning_params)
      redirect_to earning_path(@earning), notice: 'Earning was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @earning.destroy
  end

  private

  def set_earning
    @earning = Earning.find(params[:id])
  end

  def earning_params
    params.require(:earning).permit(:date, :forecast_amount, :title, :category)
  end

end
