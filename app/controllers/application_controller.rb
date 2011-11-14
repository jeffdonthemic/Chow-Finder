class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize
    
    config = YAML.load_file(File.join(::Rails.root, 'config', 'databasedotcom.yml'))
    client = Databasedotcom::Client.new(config)
    
    username = 'jeff-dfac@jeffdouglas.com'
    password = 'qo7cUF9BWJXVtFI83jypgwtaGxT3gCcDJdJrPya'
    
    client.authenticate :username => username, :password => password
    
    return client
    
  end
end
