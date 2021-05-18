class StaticPagesController < ApplicationController
  def home
    @result_top = Result.order(:value).reverse_order.first(5)
    @my_result = Result.where()
  end

  def help
  end

  def contact
  end

  def profile
  end
end
