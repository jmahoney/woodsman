class Post < ActiveRecord::Base
  def self.available_statuses
    %w(draft live foo bar)
  end
end
