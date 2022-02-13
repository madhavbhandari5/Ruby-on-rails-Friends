class ColleaguesController < ApplicationController
  before_action :set_colleague, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /colleagues or /colleagues.json
  def index
    @colleagues = Colleague.all
    @my_index= "This is index page where we can see all the data which are fetched from the database...."


  end

  # GET /colleagues/1 or /colleagues/1.json
  def show
  end

  # GET /colleagues/new
  def new
    #@colleague = Colleague.new
    @colleague=current_user.colleagues.build
  end

  # GET /colleagues/1/edit
  def edit
  end

  # POST /colleagues or /colleagues.json
  def create
    #@colleague = Colleague.new(colleague_params)
    @colleague=current_user.colleagues.build(colleague_params)

    respond_to do |format|
      if @colleague.save
        format.html { redirect_to colleague_url(@colleague), notice: "Colleague was successfully created." }
        format.json { render :show, status: :created, location: @colleague }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @colleague.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /colleagues/1 or /colleagues/1.json
  def update
    respond_to do |format|
      if @colleague.update(colleague_params)
        format.html { redirect_to colleague_url(@colleague), notice: "Colleague was successfully updated." }
        format.json { render :show, status: :ok, location: @colleague }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @colleague.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /colleagues/1 or /colleagues/1.json
  def destroy
    @colleague.destroy

    respond_to do |format|
      format.html { redirect_to colleagues_url, notice: "Colleague was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @colleague=current_user.colleagues.find_by(id: params[:id])
    redirect_to colleague_path, notice: "You are not authorized to edit this" if @colleague.nil?

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_colleague
      @colleague = Colleague.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def colleague_params
      params.require(:colleague).permit(:first_name, :last_name, :email, :phone, :twitter, :user_id)
    end
end
