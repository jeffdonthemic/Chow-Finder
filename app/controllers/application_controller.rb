class ApplicationController < ActionController::Base
  protect_from_forgery

  def dbdc_client
  
    if session[:client].nil?
      p "======= no session"
      config = YAML.load_file(File.join(::Rails.root, 'config', 'databasedotcom.yml'))
      client = Databasedotcom::Client.new(config)          
      client.authenticate :username => config[:username], :password => config[:password]
      session[:client] = client
      return client
    else
      p "======== return session"
      return session[:client]
    end
         
  end
end
