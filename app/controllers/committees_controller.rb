class CommitteesController < ApplicationController
  def index
    @committees = Committee.all.includes([:legislators, :subcommittees])

    render :index
  end

  def show
    @committee = Committee.find_by_committee_id(params[:id])
    @legislators = @committee.legislators
    @subcommittees = @committee.subcommittees

    render :show
  end
end
