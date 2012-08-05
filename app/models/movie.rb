class Movie < ActiveRecord::Base
  def self.all_ratings
    select(:rating).uniq.to_a
  end
end
