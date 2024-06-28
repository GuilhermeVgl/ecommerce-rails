class Admin::ExtrasController < AdminController
  before_action :set_admin_extra, only: %i[ show edit update destroy ]

  # GET /admin/extras or /admin/extras.json
  def index
    @admin_extras = Extra.all
  end

  # GET /admin/extras/1 or /admin/extras/1.json
  def show
  end

  # GET /admin/extras/new
  def new
    @admin_extra = Extra.new
  end

  # GET /admin/extras/1/edit
  def edit
  end

  # POST /admin/extras or /admin/extras.json
  def create
    @admin_extra = Extra.new(admin_extra_params)

    respond_to do |format|
      if @admin_extra.save
        format.html { redirect_to admin_extra_url(@admin_extra), notice: "Extra was successfully created." }
        format.json { render :show, status: :created, location: @admin_extra }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/extras/1 or /admin/extras/1.json
  def update
    respond_to do |format|
      if @admin_extra.update(admin_extra_params)
        format.html { redirect_to admin_extra_url(@admin_extra), notice: "Extra was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_extra }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_extra.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/extras/1 or /admin/extras/1.json
  def destroy
    @admin_extra.destroy!

    respond_to do |format|
      format.html { redirect_to admin_extras_url, notice: "Extra was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_extra
      @admin_extra = Extra.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def admin_extra_params
      params.require(:extra).permit(:name, :price)
    end
end
