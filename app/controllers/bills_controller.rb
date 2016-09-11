class BillsController < ApplicationController
  def index
    @bills = Bill.all.includes([:legislator, :amendments, :votes]).select { |b| b.short_title }

    render :index
  end

  def show
    @bill = Bill.where(bill_id: params[:id]).includes(:votes).first
    @related_bills = Bill.where(bill_id: @bill.related_bill_ids)
    @committees = Committee.where(committee_id: @bill.committee_ids)
    @amendments = @bill.amendments
    @votes = @bill.votes

    render :show
  end
end
