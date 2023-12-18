class CollectionController < ApplicationController
    before_action :authenticate_user!

    def index
        @assets = current_user.creatures
    end
end
