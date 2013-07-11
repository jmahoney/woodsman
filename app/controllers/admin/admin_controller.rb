class Admin::AdminController < ApplicationController
  http_basic_authenticate_with :name => ENV['WOODSMAN_USER'], 
                               :password => ENV['WOODSMAN_PASSWORD']                                                           
  respond_to :html
  layout "admin"
  
end
