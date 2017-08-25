class Admin::AlbumsController < Admin::BaseController
  before_action :set_album, only: [:show, :edit, :update,:destroy]
  after_action  :remove_images_dir, only: :destroy

  def index
    @albums = policy_scope(Album)
  end

  def show
    authorize @album
  end

  def new
    @album = Album.new
    authorize @album
  end

  def edit
    authorize @album
  end

  def create
    @album = Album.new(album_params)
    authorize @album
    if @album.save
      flash[:success] = t('messages.created', model: @album.class.model_name.human)
      redirect_to [:admin, @album]
    else      
      render :new
    end
  end

  def update
    authorize @album
    if @album.update(album_params)
      flash[:success] = t('messages.updated', model: @album.class.model_name.human)
      redirect_to [:admin, @album]
    else      
      render :edit
    end
  end

  def destroy
    authorize @album
    @album.destroy
    flash[:success] = t('messages.deleted', model: @album.class.model_name.human)
    redirect_to admin_albums_path
  end

  private

    # Removes upload images directory of a destroyed Gallery
    def remove_images_dir
      if @gallery.images.present?
        dir = File.dirname(@gallery.images.first.current_path)
        FileUtils.remove_dir dir if Dir.empty?(dir)
      end
    end
   
    # Uses callbacks to share common setup or constraints between actions
    def set_album
      @album = Album.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def album_params
      params.require(:album).permit(:title, :content, :images, :position, :status, {images: []})
    end
end
