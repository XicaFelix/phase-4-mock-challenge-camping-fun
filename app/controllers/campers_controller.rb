class CampersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :not_valid_response

    def index 
        render json: Camper.all
    end


    def show
        camper = find_camper
        render json: camper, serializer: CamperActivitySerializer
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def find_camper
        Camper.find(params[:id])
    end

    def camper_params
        params.permit(:name, :age)
    end

    def not_found_response
        render json: {error: "Camper not found"}, status: :not_found
    end

    def not_valid_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
