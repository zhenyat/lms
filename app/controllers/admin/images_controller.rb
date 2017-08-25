class Admin::ImagesController < ApplicationController
  before_action :set_album

  def create
    add_more_images(images_params[:images])
    flash[:error] = "Failed uploading images" unless @album.save
    redirect_back(fallback_location: admin_root_path)
  end
  
  def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting image" unless @album.save
    redirect_back(fallback_location: admin_root_path)
  end

  private

  def set_album
    @album = Album.find(params[:album_id])
  end

  def add_more_images(new_images)
    images = @album.images      # copy the old images 
    images += new_images          # concat old images with new ones
    @album.images = images      # assign back
  end

  def remove_image_at_index(index)
    remain_images = @album.images                   # copy the array
    deleted_image = remain_images.delete_at(index)  # delete the target image
    deleted_image.try(:remove!)                     # delete image from S3
    @album.images = remain_images                   # re-assign back
  end
  
  def images_params
    params.require(:album).permit({images: []})   # allow nested params as array
  end
end
