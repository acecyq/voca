require 'twilio-ruby'
require 'dotenv/load'

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :sms]
  before_action :authenticate_user!, except: [:home, :index]

  # GET /orders
  # GET /orders.json
  def index
    if user_signed_in?
      @orders = Order.where(user_id: current_user)
    elsif params[:store]
      if User.find_by id: params[:store]
        @user = User.find(params[:store])
        @orders = Order.where(user_id: @user.id)
      else
        render "home"
        flash[:notice] = "Store ID does not exist"
      end
    else
      redirect_to home_orders_path
    end
    # render json: @orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    sender = '+19802701816' # Your Twilio number
    receiver = '+65' + @order.number # Your mobile phone number
  
    client.messages.create(
      from: sender,
      to: receiver,
      body: "Hi " + @order.name + ", you have placed an order with " + current_user.company_name + "!"
    )
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def sms
    redirect_to orders_path
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    client = Twilio::REST::Client.new(account_sid, auth_token)

    sender = '+19802701816' # Your Twilio number
    receiver = '+65' + @order.number # Your mobile phone number
  
    client.messages.create(
      from: sender,
      to: receiver,
      body: "Hi " + @order.name + ", your order is ready! See ya shortly!"
    )
  end

  def home 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :number, :description)
    end
end
