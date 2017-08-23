class PagesController < ApplicationController
  def clubs
    @clubs = Club.active
  end
  
  def home
    @directions = Direction.active
  end

  def subjects
    @subjects = Subject.active
  end
  
  def tours
    @tours = Tour.active
  end
end
