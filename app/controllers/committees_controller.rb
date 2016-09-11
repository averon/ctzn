class CommitteesController < ApplicationController
  def index
    @committees = Committee.all.includes(:legislators)

    render :index
  end

  def show
    @committee = Committee.find_by_committee_id(params[:id])
    @legislators = @committee.legislators

    render :show
  end
end
