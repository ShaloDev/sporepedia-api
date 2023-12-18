class Creature < ApplicationRecord
    has_many :creature_saves
    has_many :users, through: :creature_saves

    validates :creature_id, uniqueness: true
end
