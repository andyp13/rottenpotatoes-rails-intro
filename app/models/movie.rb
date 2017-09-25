class Movie < ActiveRecord::Base
    def self.acceptable_ratings
       ['G', 'PG', 'PG-13', 'R'] 
    end
end
