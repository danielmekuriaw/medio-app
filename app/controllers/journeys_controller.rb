class JourneysController < ApplicationController

    def meet_view
        @journey = Journey.find_by(id: params[:id])
        byebug
    end
    
    def create
        @journey = Journey.create(journey_params)
        @journey.save
        redirect_to "/journeys/#{@journey.id}/meet_view"
    end

    def show
        @journey = Journey.find_by(id: params[:id])
    end

    private

    def journey_params
        params.require(:journey).permit(:point1, :point2)
    end

end