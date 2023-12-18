class CreatureSafe < ApplicationRecord
    belongs_to :user
    belongs_to :creature
end
