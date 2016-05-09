class StaticController < ApplicationController

  def home
    render plain: 'Hello world!'
  end
  
end
