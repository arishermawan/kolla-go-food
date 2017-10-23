class HomeController < ApplicationController
  def hello
    @time = Date.today
  end

  def goodbye
    @tomorrow = Date.today + 1
  end

end
