class BillsController < ApplicationController
  def index
    @bills = Bill.all.includes([:legislator, :votes]).select { |b| b.short_title }

    render :index
  end

  def show
    @bill = Bill.where(bill_id: params[:id]).includes(:votes).first
    @related_bills = Bill.where(bill_id: @bill.related_bill_ids)

    render :show
  end
end
