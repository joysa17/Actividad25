class SalesController < ApplicationController
  def new
  	@sale = Sale.new
  end

  def create
  	sale = Sale.new(sales_params)
  	prepare_sale(sale) 
    redirect_to sales_done_path 	
  end

  def done
    @sale = Sale.all.last
  end

private
  def sales_params
  	params.require(:sale)
    .permit(:cod, :detail, :category, :value, :discount, :tax)
  end

  def prepare_sale(sale)
  	sale.cod = Random.rand(10...10000)
  	sale.value = (sales_params[:value].to_i)*(100 - sales_params[:discount].to_i)
  	if sales_params[:tax].to_i == 0 
	  	sale.total = sale.value * 1.19
      sale.tax = 19

	  else
      sale.tax = 0
	  	sale.total = sale.value
	  end
	  	sale.save
	end 
end
