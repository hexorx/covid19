class Api::V1::ReportsController < ApplicationController
  def index
    @state = State.find(params[:state_id].downcase)
    @reports = @state.reports.order(date: 'desc').paginate(
      page: params[:page],
      per_page: params[:per_page]
    )

    render json: {
      current_page: @reports.current_page,
      per_page: @reports.per_page,
      total_entries: @reports.total_entries,
      state: @state,
      reports: @reports
    }
  end
end
