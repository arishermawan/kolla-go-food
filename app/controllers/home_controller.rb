class HomeController < ApplicationController
  def hello
    @time = Date.today
    @users = User.all
  end

  def goodbye
    @tomorrow = Date.today + 1
  end

end
