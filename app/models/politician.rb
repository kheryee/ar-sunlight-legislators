require_relative '../../db/config'

class Politician < ActiveRecord::Base

  def name
    "#{firstname} #{lastname}"
  end

end
