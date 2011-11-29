class FacilityController < ApplicationController
  include Databasedotcom::Rails::Controller
  
  def show
    @facility = Facility__c.find(params[:id])
    @location = Location__c.find(@facility.Location__c)
  end

  def new
    @location = Location__c.find(params[:id])
  end
  
  def create
    fac = Facility__c.new
    fac.Name = params["Name"]
    fac.Address__c = params["Address__c"]
    fac.Hours__c = params["Hours__c"]
    fac.Prices__c = params["Prices__c"]
    fac.Description__c = params["Description__c"]
    fac.Monday__c = params["Monday__c"]
    fac.Tuesday__c = params["Tuesday__c"]
    fac.Wednesday__c = params["Wednesday__c"]
    fac.Thursday__c = params["Thursday__c"]
    fac.Friday__c = params["Friday__c"]
    fac.Saturday__c = params["Saturday__c"]
    fac.Sunday__c = params["Sunday__c"]
    fac.Location__c = params[:id]
    fac.Is_Active__c = true
    id = fac.save
    redirect_to "/facility/"+id
  end
  
  def edit
    @facility = Facility__c.find(params[:id])
  end
  
  def update
    @facility = Facility__c.find(params[:id])
    @facility.update_attributes Facility__c.coerce_params(params[:facility])
    redirect_to "/facility/"+params[:id]
  end

end
