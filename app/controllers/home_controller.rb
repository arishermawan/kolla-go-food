class HomeController < ApplicationController
  def hello
    @time = Date.today
  end
end
