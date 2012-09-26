class Category < ActiveRecord::Base
  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true

  has_many :events

  class << self
    def to_dropdown
      self.all.collect { |c| [c.name, c.id] }
    end
  end
end
