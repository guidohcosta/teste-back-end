class VisitsController < ApplicationController
  def index
    @visits = visit_list.visits
  end

  private

  def visit_list
    JSON.parse(visit_service.list, object_class: OpenStruct)
  end

  def visit_service
    ::VisitService.new
  end
end
