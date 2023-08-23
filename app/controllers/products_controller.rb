class ProductsController < ApplicationController
    before_action :set_product,only: [:view,:destroy, :show]
    before_action :correct_user,only: [:edit,:update,:destroy]
    def index
        @product = Product.all
        @q = Product.ransack(params[:q])
        @product = @q.result(distinct: true)
    end
    def new
        @product = Product.new
    end
    def create
        @product = Product.create(product_params)
        if @product.save
            redirect_to product_path(@product),notice: 'Product added successfully'
        else
            render :new,status: :bad_request
        end
    end
    def show
        @comment = @product.comments.order('Created_at DESC')
        @product.update(views: @product.views + 1)
    end
    def edit
        @product = Product.find_by(id: params[:id])
    end
    def update
        @product = Product.find_by(id: params[:id])
        if @product.update(product_params)
            redirect_to product_path(@product),notice: 'Product Updated!'
        else
            render :edit,status: :bad_request
        end
    end
    def destroy
        if @product.destroy
            redirect_to root_path,alert: 'Product Deleted!'
        end
    end
    private
    def product_params
        params.require(:product).permit(:name, :oriprice, :disprice, :brand, :category, :image, :user_id)
    end
    def set_product
        @product = Product.find_by(id: params[:id])
    end
    def correct_user
        if current_user.role == 'admin' || current_user.id == @product.user.id
        else
            redirect_to root_path,alert: 'Only admin or post owner can perform this task'
        end
    end
end
