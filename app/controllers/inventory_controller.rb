require './config/environment'

class InventoryController < ApplicationController
    configure do
        set :public_folder, 'public'
        set :views, 'app/views'
    end

    get '/inventory/index' do
        erb :'/inventory/index'
    end
end