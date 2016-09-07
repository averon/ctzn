class BillsController < ApplicationController
  def index
    @bills = Bill.all.select { |b| b.short_title }

    render :index
  end
end
