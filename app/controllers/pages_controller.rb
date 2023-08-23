class PagesController < ApplicationController
  before_action :verify_admin, only: [:admin, :product, :destroy]
  def home
  end
  def about
  end

  def admin
    @user = User.all
    @online_user = User.where("last_seen_at > ?", 5.minutes.ago)
  end
  def product
    @product = Product.all
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    redirect_to admin_path, alert: "User account deleted successfully."
  end
  private
  def verify_admin
    redirect_to root_path, alert: 'Only admin can authorize this!' unless current_user.admin?
  end
end
