class WorksController < ApplicationController
  before_action :set_work, only: [:show]

  def index
    @works = Work.all
  end

  def show
    @work.inc(:visit_count => 1)
  end

  private

    def set_work
      @work = Work.find(params[:id])
    end
end
