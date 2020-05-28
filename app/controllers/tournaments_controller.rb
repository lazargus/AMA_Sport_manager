class TournamentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params[:id])
    respond_to do |format|
      format.html
      format.json do
        render json: {
          attachmentPartial:
            render_to_string(
              partial: 'tournaments/calendar_modal_content',
              formats: :html,
              layout: false,
              locals: { tournament: @tournament }
            )
        }
      end
    end
  end
end
