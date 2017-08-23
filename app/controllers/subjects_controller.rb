class SubjectsController < ApplicationController
  def index
    @subjects = Subject.active
  end

  def show
  end
end
