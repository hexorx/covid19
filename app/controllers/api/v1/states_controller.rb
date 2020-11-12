class Api::V1::StatesController < ApplicationController
  def index
    @states = State.paginate(page: params[:page], per_page: params[:per_page])

    render json: {
      current_page: @states.current_page,
      per_page: @states.per_page,
      total_entries: @states.total_entries,
      states: @states.as_json(only: [:code, :name], methods: [:id])
    }
  end

  def show
    @state = State.find(params[:id].downcase)
    render json: @state.to_json(methods: [:id])
  end
end
