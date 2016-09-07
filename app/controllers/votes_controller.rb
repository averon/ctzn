class VotesController < ApplicationController
  def index
    @votes = Vote.all

    render :index
  end

  def show
    @vote = Vote.find_by_roll_id(params[:id])
    legislators = Legislator.where(chamber: @vote.chamber)

    apply_votes(@vote, legislators)
    @legislators = legislators.select { |l| l.vote }

    render :show
  end

  private

  def apply_votes(vote, legislators)
    vote.votes.each do |vote|
      if legislator = legislators.find { |l| l.bioguide_id == vote.children[0]['name-id'] }
        legislator.vote = vote.children[1].content
      end
    end
  end
end
