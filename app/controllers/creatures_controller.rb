class CreaturesController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destroy]
    before_action :set_creature, only: [:destroy]

    def index
        page = params[:page].to_i
        per_page = params[:per_page].to_i || 10
        start_index = (page - 1) * per_page
        url = SporeScrapper.asset_search_url(params[:search_type], start_index, per_page)
        response = SporeScrapper.fetch_response(url)
        @assets = SporeScrapper.extract_assets(response)
    end

    def download 
        image_url = SporeScrapper.large_asset_url(params[:id])
        image_data = URI.open(image_url).read
        send_data image_data, filename: "#{params[:id]}.png", disposition: 'attachment'
    end

    def show
        stats_url = SporeScrapper.stats_for_creature_url(params[:id])
        response = SporeScrapper.fetch_response(stats_url)
        @stats = SporeScrapper.extract_stats(response)
    end

    def create
        @creature = Creature.new(creature_params)

        if @creature.save
            current_user.creatures << @creature
            redirect_to collection_index_path
        else
            flash[:notice] = @creature.errors.full_messages.to_sentence
            redirect_to root_path, status: :unprocessable_entity
        end
    end

    def destroy
        current_user.creature_saves.where(creature_id: @creature.id).destroy_all
        @creature.destroy
        redirect_to collection_index_path, status: :see_other
    end

    private 

    def creature_params
        params.permit(:creature_id, :image, :name, :author, :description, :created)
    end

    def set_creature
        @creature = Creature.find(params[:id])
    end
end
