class V1::Survivors::RecordsController < V1::ApiController
  # POST /records
  def create
    #TODO: change for service
    # @survivor = Survivor.find(params[:survivor_id])
    # @by_survivor = Survivor.find(record_params[:by_survivor_id])
    @record = Record.new(record_params)

    # TODO: change for strategy service
    if @record.save
      render json: @record, status: :created, location: survivor_records_path(@record)
    else
      render_save_error!(@record, :unprocessable_entity)
    end
  end

  private

  def record_params
    params.require(:data).require(:attributes).permit(:survivor_id, :by_survivor_id, :kind)
  end
end
