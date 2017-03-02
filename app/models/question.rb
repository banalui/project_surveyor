class Question < ApplicationRecord
	belongs_to :survey
	has_many :choices, :dependent => :destroy, inverse_of: :question
	accepts_nested_attributes_for :choices,
                                  :reject_if => :all_blank,
                                  :allow_destroy => true
end
