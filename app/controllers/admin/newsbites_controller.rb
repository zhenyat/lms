class Admin::NewsbitesController < Admin::BaseController
  before_action :set_newsbite, only: [:show, :edit, :update,:destroy]

  def index
    @newsbites = policy_scope(Newsbite)
  end

  def show
    authorize @newsbite
  end

  def new
    @newsbite = Newsbite.new
    authorize @newsbite
  end

  def edit
    authorize @newsbite
  end

  def create
    @newsbite = Newsbite.new(newsbite_params)
    authorize @newsbite
    if @newsbite.save
      flash[:success] = t('messages.created', model: @newsbite.class.model_name.human)
      redirect_to [:admin, @newsbite]
    else      
      render :new
    end
  end

  def update
    authorize @newsbite
    if @newsbite.update(newsbite_params)
      flash[:success] = t('messages.updated', model: @newsbite.class.model_name.human)
      redirect_to [:admin, @newsbite]
    else      
      render :edit
    end
  end

  def destroy
    authorize @newsbite
    @newsbite.destroy
    flash[:success] = t('messages.deleted', model: @newsbite.class.model_name.human)
    redirect_to admin_newsbites_path
  end

  private

    # Uses callbacks to share common setup or constraints between actions
    def set_newsbite
      @newsbite = Newsbite.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def newsbite_params
      params.require(:newsbite).permit(:title, :content, :cover, :published_at, :status)
    end
end
