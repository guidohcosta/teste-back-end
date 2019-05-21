class V1::VisitsController < ApplicationController
  before_action :set_visit, only: :create
  before_action :find_visits, only: :index

  def create
    if @visit.save
      render json: { status: :success }
    else
      render json: {
        status: :failure,
        errors: @visit.errors.messages
      }
    end
  end

  def index
    render json: { visits: @visits }
  end

  private

  def visit_params
    params.require(:visit)
          .permit(:identifier, :url, :created_at)
  end

  def set_visit
    @visit = Visit.new visit_params
  end

  def find_visits
    @visits = Visit.all
  end
end
