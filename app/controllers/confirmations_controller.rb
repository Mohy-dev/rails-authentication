class ConfirmationsController < ApplicationController


  def create
    @user = User.find_by(email: params[:user][:email].downcase)

    if @user.present? && @user.unconfirmed?
      @user.send_confirmation_email!
      redirect_to  root_path, notice: "Check your email for confirmation instructions"
    else
      redirect_to  root_path, notic: "We couldn't find a user with that email address"
    end
  end

  def edit
    @user = User.find_signed(params[:confirmation_token], purpose: :confirm_email)

    if @user.present?
      @user.confirm!
      login @user
      redirect_to root_path, notice: "Your email address has been successfully confirmed"
    else
      redirect_to root_path, notice: "Invalid token"
    end
  end

  def new
    @user = User.new
  end

end
