class OrdersController < ApplicationController
  include CurrentCart
  skip_before_action :authorize, only: [:new, :create, ]
  before_action :set_cart, only: [:new, :create]
  before_action :cart_not_empty, only: [:new]
  before_action :set_order, only: [:edit, :update, :destroy, :show]

  def index
    if params[:name]
     fmax = params[:max]
      if fmax == ""
        fmax = Order.maximum(:total)
      else
        fmax = fmax.to_i
      end

      @orders = Order.where('name LIKE ?', "%#{params[:name]}%").where('address LIKE ?', "%#{params[:address]}%").where('email LIKE ?', "%#{params[:email]}%").where('total >= ?', "#{params[:min].to_i}").where('total <= ?', "#{fmax}")
    else
      @orders = Order.all
    end
  end

  def show
  end

  def search
    if params[:name]
     fmax = params[:max]
      if fmax == ""
        fmax = Order.maximum(:total)
      else
        fmax = fmax.to_i
      end

      @orders = Order.where('name LIKE ?', "%#{params[:name]}%").where('address LIKE ?', "%#{params[:address]}%").where('email LIKE ?', "%#{params[:email]}%").where('total >= ?', "#{params[:min].to_i}").where('total <= ?', "#{fmax}")
    else
      @orders = Order.all
    end
  end

  def new
    @order = Order.new
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.add_line_items(@cart)
    if @order.voucher_code != ''
      @order.voucher_id = Voucher.find_by(code: @order.voucher_code).id
    end
    @order.total = @order.total_price
    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        # OrderMailer.received(@order).deliver_later  Active Jobs Asyncronus
        # OrderMailer.received(@order).deliver # Syncronus

        format.html{redirect_to @order, notice: "orders succesfully saved"}
      else
        format.html{render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html{ redirect_to @order, notice: 'Order was succesfuly updated'}
      else
        format.html{ render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @order.destroy
        format.html{ redirect_to orders_path, notice: 'Order was succesfuly deleted'}
      end
    end
  end


  private

  def cart_not_empty
    if @cart.line_items.empty?
      redirect_to store_index_url
    end
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :email, :address, :payment_type, :voucher_code)
  end

end
