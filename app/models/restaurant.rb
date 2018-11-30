class Restaurant < ApplicationRecord
    belongs_to :user
    has_many :reviews

    validates_presence_of :name, :description, :contactInfo, :location


    def self.search(search)
        where("name LIKE ? OR location LIKE ?", "%#{search}%", "%#{search}%")
    end
end
