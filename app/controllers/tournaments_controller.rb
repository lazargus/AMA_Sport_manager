class TournamentsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index

    @tournament_user = []
    Tournament.all.to_a.each do |t|
      unless t.earnings.empty?
        @tournament_user << t if t.earnings.where(user: current_user)
      end
    end

    # @tournaments = Tournament.all.to_a.reject { |item| @tournament_user.include? item }
    @tournaments =
                    if params[:format] == "first_trimester"
                      Tournament.where('end_date <?', Date.new(2020,3,31)).all.order(start_date: :asc).to_a.reject { |item| @tournament_user.include? item }
                    elsif params[:format] == "second_trimester"
                      Tournament.where('start_date BETWEEN ? AND ?', Date.new(2020,3,31), Date.new(2020,6,30)).all.order(start_date: :asc).to_a.reject { |item| @tournament_user.include? item }
                    elsif params[:format] == "third_trimester"
                      Tournament.where('start_date BETWEEN ? AND ?', Date.new(2020,6,30), Date.new(2020,9,30)).all.order(start_date: :asc).to_a.reject { |item| @tournament_user.include? item }
                    elsif params[:format] == "fourth_trimester"
                      Tournament.where('start_date BETWEEN ? AND ?', Date.new(2020,9,30), Date.new(2020,12,31)).all.order(start_date: :asc).to_a.reject { |item| @tournament_user.include? item }
                    else
                      Tournament.all.to_a.reject { |item| @tournament_user.include? item }
                    end
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
