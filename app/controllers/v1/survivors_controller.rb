class V1::SurvivorsController < V1::ApiController
  before_action :set_survivor, only: %i[show update nearest]

  def show
    render json: @survivor, status: :ok
  end

  def create
    survivor = Survivor.new(survivor_params)

    if survivor.save
      render json: survivor, status: :ok
    else
      render_save_error!(survivor, :unprocessable_entity)
    end
  end

  def update
    if @survivor.update(survivor_params)
      render json: @survivor
    else
      render_save_error!(@survivor, :unprocessable_entity)
    end
  end

  def nearest
    if Automation::NearestSurvivorUpdater.call(@survivor.location_feature)
      render json: @survivor, serializer: NearestSurvivorSerializer
    else
      render_save_error!(@survivor, :unprocessable_entity)
    end
  end

  private

  def survivor_params
    params
      .require(:data)
      .require(:attributes)
      .permit(:name, :gender, location_feature_attributes: [:latitude, :longitude])
  end

  def set_survivor
    @survivor = Survivor.find(params[:id])
  end
end
