#
# Sinatra app
#
# It is put in a separate file to make sure we are getting a realistic test
#
require 'sinatra/base'
require 'sinatra/resources'

class Application < Sinatra::Base
  set :app_file, __FILE__
  register Sinatra::Resources

  resource :users do
    get do
      'yo'
    end
    
    member do
      get do
        'hi'
      end
      
      get :recent do
        'recent'
      end
    end
    
  end

  resource :forums do
    resource :admin do
      get do
        'woot'
      end
      
      post do
        'success'
      end
    end
    
  end
end

Application.run!
