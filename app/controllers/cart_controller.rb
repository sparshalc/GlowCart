class CartController < ApplicationController
  before_action :authenticate_user!

  def show
    @render_cart = true
  end

  def add
    @product = Product.find_by(id: params[:id])
    quantity = params[:quantity].to_i
    current_orderable = @cart.orderables.find_by(product_id: @product.id)

    if current_orderable && quantity > 0
    elsif quantity <= 0
      current_orderable.destroy
    else
      @cart.orderables.create(product: @product, quantity: quantity)
      product_name = @product.name
      product_price = @product.disprice
      update_lcd(product_name, product_price)
      send_serial_command('1') # Send command to Arduino to trigger LED blinking

      redirect_to cart_path, notice: 'Added to cart'
      return
    end
  end

  def destroy
    Orderable.find_by(id: params[:id]).destroy
    redirect_to cart_path, alert: 'Removed From Cart!'
  end

  private

  def update_lcd(name, price)
    serial_port = ::Serial.new('COM3', 9600)
    serial_port.write("#{name} #{price}\n")
    serial_port.close
  end

  def send_serial_command(command)
    port_str = 'COM3'
    baud_rate = 9600

    serial_port = Serial.new(port_str, baud_rate)

    begin
      serial_port.write(command)
    rescue => e
      puts "Error communicating with the serial port: #{e.message}"
    ensure
      serial_port.close
    end
  end
end
