class LocationController < ApplicationController
  layout "mobile"

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

end
