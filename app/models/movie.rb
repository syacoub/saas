class Movie < ActiveRecord::Base
  def self.all_ratings
    find(:all, :select => "distinct(rating)").map {|m| m.rating}
  end
end
