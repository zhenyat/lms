class AlbumsController < ApplicationController
  def show
    puts "SHOW-1: #{params}"
    @album = Album.find(params[:format])
    puts "SHOW-2: #{@album.title}"
  end
end
