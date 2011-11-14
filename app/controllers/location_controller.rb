class LocationController < ApplicationController
  layout "mobile"

  def index

    client = authorize
    @locations = client.materialize("Location__c").all

  end

  def show

    client = authorize

    client.materialize("Location__c")
    @location = Location__c.find(params[:id])

    client.materialize("Facility__c")
    @facilities = Facility__c.find_all_by_Location__c(params[:id])

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
