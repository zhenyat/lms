class Admin::ToursController < Admin::BaseController
  before_action :set_tour, only: [:show, :edit, :update,:destroy]
  after_action  :remove_cover_dir, only: :destroy

  def index
    @tours = policy_scope(Tour)
  end

  def show
    authorize @tour
  end

  def new
    @tour = Tour.new
    authorize @tour
  end

  def edit
    authorize @tour
  end

  def create
    @tour = Tour.new(tour_params)
    authorize @tour
    if @tour.save
      flash[:success] = t('messages.created', model: @tour.class.model_name.human)
      redirect_to [:admin, @tour]
    else      
      render :new
    end
  end

  def update
    authorize @tour
    if @tour.update(tour_params)
      flash[:success] = t('messages.updated', model: @tour.class.model_name.human)
      redirect_to [:admin, @tour]
    else      
      render :edit
    end
  end

  def destroy
    authorize @tour
    @tour.destroy
    flash[:success] = t('messages.deleted', model: @tour.class.model_name.human)
    redirect_to admin_tours_path
  end

  private
    # Removes upload cover directory of a destroyed Account
    def remove_cover_dir
      dir =  "public/uploads/subject/cover/#{@subject.id}"
      FileUtils.remove_dir dir if Dir.empty?(dir)
    end

    # Uses callbacks to share common setup or constraints between actions
    def set_tour
      @tour = Tour.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def tour_params
      params.require(:tour).permit(:title, :start_date, :finish_date, :content, :cover, :status, :remove_cover)
    end
end
