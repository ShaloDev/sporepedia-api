class CreaturesController < ApplicationController
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
end
