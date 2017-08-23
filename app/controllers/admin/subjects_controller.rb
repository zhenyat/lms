class Admin::SubjectsController < Admin::BaseController
  before_action :set_subject, only: [:show, :edit, :update,:destroy]
  after_action  :remove_cover_dir, only: :destroy

  def index
    @subjects = policy_scope(Subject)
  end

  def show
    authorize @subject
  end

  def new
    @subject = Subject.new
    authorize @subject
  end

  def edit
    authorize @subject
  end

  def create
    @subject = Subject.new(subject_params)
    authorize @subject
    if @subject.save
      flash[:success] = t('messages.created', model: @subject.class.model_name.human)
      redirect_to [:admin, @subject]
    else      
      render :new
    end
  end

  def update
    authorize @subject
    if @subject.update(subject_params)
      flash[:success] = t('messages.updated', model: @subject.class.model_name.human)
      redirect_to [:admin, @subject]
    else      
      render :edit
    end
  end

  def destroy
    authorize @subject
    @subject.destroy
    flash[:success] = t('messages.deleted', model: @subject.class.model_name.human)
    redirect_to admin_subjects_path
  end

  private
    # Removes upload cover directory of a destroyed Account
    def remove_cover_dir
      dir =  "public/uploads/subject/cover/#{@subject.id}"
      FileUtils.remove_dir dir if Dir.empty?(dir)
    end

    # Uses callbacks to share common setup or constraints between actions
    def set_subject
      @subject = Subject.find(params[:id])
    end

    # Only allows a trusted parameter 'white list' through
    def subject_params
      params.require(:subject).permit(:name, :title, :content, :cover, :position, :status, :remove_cover)
    end
end
