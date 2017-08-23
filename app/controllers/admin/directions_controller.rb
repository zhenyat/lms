class Admin::DirectionsController < Admin::BaseController
  before_action :set_direction, only: [:show, :edit, :update,:destroy]

  def index
    @directions = policy_scope(Direction)
  end

  def show
    authorize @direction
  end

  def new
    @direction = Direction.new
    authorize @direction
  end

  def edit
    authorize @direction
  end

  def create
    @direction = Direction.new(direction_params)
    authorize @direction
    if @direction.save
      flash[:success] = t('messages.created', model: @direction.class.model_name.human)
      redirect_to [:admin, @direction]
    else      
      render :new
    end
  end

  def update
    authorize @direction
    if @direction.update(direction_params)
      flash[:success] = t('messages.updated', model: @direction.class.model_name.human)
      redirect_to [:admin, @direction]
    else      
      render :edit
    end
  end

  def destroy
    authorize @direction
    @direction.destroy
    flash[:success] = t('messages.deleted', model: @direction.class.model_name.human)
    redirect_to admin_directions_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_direction
      @direction = Direction.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def direction_params
      params.require(:direction).permit(:name, :title, :cover, :position, :status)
    end
end
