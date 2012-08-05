class Movie < ActiveRecord::Base
  def self.all_ratings
    select(:name).uniq
  end
end
