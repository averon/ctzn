class LegislatorsController < ApplicationController
  def index
    @legislators = Legislator.all

    render :index
  end

  def show
    @legislator = Legislator.find_by_bioguide_id(params[:id])
    @bills = @legislator.bills
    @votes = @legislator.votes.includes(:bill).group_by(&:bill_id)

    render :show
  end

  def location
    options = params[:zip] ? { zip: params[:zip] } : { latitude: params[:latitude], longitude: params[:longitude] }
    bioguide_ids = SunlightClient.get(:'legislators/locate', options).map { |l| l['bioguide_id'] }
    @legislators = Legislator.where(bioguide_id: bioguide_ids).sort_by(&:chamber)

    render :location
  end
end
