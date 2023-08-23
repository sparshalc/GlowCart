class ApplicationController < ActionController::Base
    before_action :set_search

    def set_search
        @q = Product.ransack(params[:q])
    end
    
    before_action :set_render_cart
    before_action :initialize_cart
    before_action :authenticate_user!
    before_action :update_last_seen_at, if: -> { user_signed_in? && (current_user.last_seen_at.nil? || current_user.last_seen_at < 1.minutes.ago)}

    def set_search
        @q = Product.ransack(params[:q])
    end

    def set_render_cart
        @render_cart = true
    end
    def initialize_cart
        @cart ||= Cart.find_by(id: session[:cart_id])
        if @cart.nil?
            @cart = Cart.create
            session[:cart_id] = @cart.id
        end
    end

    def update_last_seen_at
        current_user.update_attribute(:last_seen_at, Time.now)
    end
end
