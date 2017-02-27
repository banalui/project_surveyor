class Survey < ApplicationRecord
		validates       :title, :description,
                                :presence => true
        validates       :title, :length =>{ :in => 5..64 }
        validates       :description, :length =>{ :in => 10..256 }

        has_many :questions
end