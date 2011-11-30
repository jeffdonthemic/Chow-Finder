class LocationController < ApplicationController
  include Databasedotcom::Rails::Controller

  def index
    #@locations = Location__c.all
    @locations = dbdc_client.query("select id, name, facilities__c from location__c order by name")
  end

  def show 
    @location = Location__c.find(params[:id])
    @facilities = dbdc_client.query("select id, name from facility__c where is_active__c = true and location__c = '"+params[:id]+"' order by name")
  end
    
  def create
    location = Location__c.new
    location.Name = params["Name"]
    location.State__c = params["State__c"]
    location.OwnerId = '005U0000000J3ZM'
    id = location.save
    redirect_to "/location/"+id
  end
  
  def favorites
    if !cookies[:user_token].nil?
      @locations = dbdc_client.query("select Id, Location__r.Id, Location__r.Name, Location__r.Facilities__c from 
        Favorite_Location__c  where Chow_User__c = '"+cookies[:user_token]+"' order by Location__r.Name")
        
      if @locations.length.eql?(0)
        @locations = nil
      end
    end
  end
  
  def favorite
    
    # if their is no cookie for the user, create one
    if cookies[:user_token].nil?
      u = Chow_User__c.new
      u.OwnerId = '005U0000000J3ZM'
      u = u.save  
      #save the id in the cookie
      cookies.permanent[:user_token] = u
    end
    
    fav = Favorite_Location__c.new
    fav.Location__c = params[:id]
    fav.Chow_User__c = cookies[:user_token]
    fav.OwnerId = '005U0000000J3ZM'
    fav = fav.save

    redirect_to "/location/"+params[:id]
    
  end

end
