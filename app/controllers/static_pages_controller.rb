class StaticPagesController < ApplicationController
  def home
    @result_top = Result.top
    @my_result = Result.my_results(current_user).last(5)
  end

  def help
  end

  def contact
  end

  def profile
  end
end
