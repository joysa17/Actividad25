class SalesController < ApplicationController
  def new
  	@sale = Sale.new
  end

  def create
  	sale = sales_params
  	prepare_sale(sale)
  	
  end

private
  def sales_params
  	params.require(:sale).permit.(:detail, :category, :value, :discount, :tax)
  end

  def prepare_sales
  	sale.cod = Random.rand(10...10000)
  	sale.value = (sales_params[:value].to_i)*(100 - sales_params[:discount].to_i)
  	if sales_params[:tax] == 0 
	  	sale.total = sale.value *1,19  
	  else
	  	sale.total = sale.value
	  end
	  	sale.save
	end 
end
