class AdminsBackoffice::SubjectsController < AdminsBackofficeController
  before_action :set_subject, only: [:edit, :update, :destroy]

  def index
    @subjects = Subject.all.order(:description).page(params[:page])
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(params_subjects)
    if @subject.save
      redirect_to admins_backoffice_subjects_path, notice: "Subject saved successfull"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @subject.update(params_subjects)
      redirect_to admins_backoffice_subjects_path, notice: "Subject updated successfull"
    else 
      render :edit
    end
  end 

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path,  notice: "Subject deleted successfull"
    else 
      render :index
    end
  end

  private 

  def params_subjects
    params.require(:subject).permit(:description, :id)
  end  

  def set_subject
    @subject = Subject.find(params[:id])
  end

end