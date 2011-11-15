class LocationController < ApplicationController

  def index

    client = authorize
    @locations = client.query("select id, name, facilities__c from location__c order by name")

  end

  def show 

    client = authorize
    client.materialize("Location__c")
    @location = Location__c.find(params[:id])
    @facilities = client.query("select id, name from facility__c where is_active__c = true and location__c = '"+params[:id]+"' order by name")

  end
    
  def create
    
    client = authorize  
    client.materialize("Location__c")
    location = Location__c.new
    location.Name = params["Name"]
    location.State__c = params["State__c"]
    location.OwnerId = '005U0000000hi2M'
    location = location.save
    
    redirect_to "/location/"+location.Id
    
  end
  
  def favorites
    if !cookies[:user_token].nil?
      client = authorize
      @locations = client.query("select Id, Location__r.Id, Location__r.Name, Location__r.Facilities__c from 
        Favorite_Location__c  where Chow_User__c = '"+cookies[:user_token]+"' order by Location__r.Name")
        
      if @locations.length.eql?(0)
        @locations = nil
      end
        
    end
    
  end
  
  def favorite

    client = authorize
    
    # if their is no cookie for the user, create one
    if cookies[:user_token].nil?
      client.materialize("Chow_User__c")
      u = Chow_User__c.new
      u.OwnerId = '005U0000000hi2M'
      u = u.save  
      #save the id in the cookie
      cookies.permanent[:user_token] = u
    end
    
    client.materialize("Favorite_Location__c")
    fav = Favorite_Location__c.new
    fav.Location__c = params[:id]
    fav.Chow_User__c = cookies[:user_token]
    fav.OwnerId = '005U0000000hi2M'
    fav = fav.save

    redirect_to "/location/"+params[:id]
    
  end

end
