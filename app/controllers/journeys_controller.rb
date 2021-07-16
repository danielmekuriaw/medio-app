class JourneysController < ApplicationController
    before_action :redirect_if_not_logged_in, only: [:meet_view]
    
    def meet_view
        @journey = Journey.find_by(id: params[:id])
        @suggestions = @journey.suggestions
    end

    private

    def journey_params
        params.require(:journey).permit(:point1, :point2, :radius, :mode, :preference)
    end

end