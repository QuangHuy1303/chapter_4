class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
    render html: "hello, world!"
  end
  def help
  end
  def contact
  end
  def about
  end
  def new
  end
end
