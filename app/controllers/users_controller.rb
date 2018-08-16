require 'rqrcode'

class UsersController < ApplicationController
  before_action :find_user

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def find_user
      @user = current_user
      @qr = RQRCode::QRCode.new( '5ea8dc66.ngrok.io/orders?store=' + current_user.id.to_s, :size => 4, :level => :h )
    end
end
