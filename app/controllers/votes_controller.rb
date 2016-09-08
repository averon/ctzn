class VotesController < ApplicationController
  def index
    @votes = Vote.all

    render :index
  end

  def show
    @vote = Vote.find_by_roll_id(params[:id])
    @cast_votes = @vote.cast_votes.includes(:legislator)

    render :show
  end
end
