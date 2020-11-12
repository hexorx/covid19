class Api::V1::SearchesController < ApplicationController
  def show
    @search = Search.find(params[:id])
    render json: search_results(@search)
  end

  def create
    @search = Search.find_or_create_by!(start: params[:start], end: params[:end])
    render json: search_results(@search)
  end

  private

  def search_results(search)
    search.as_json(methods: [:results])
  end
end
