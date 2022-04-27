class V1::Survivors::RecordsController < V1::ApiController
  # POST /records
  def create
    unless record_params.present?
      return render json: {
          field: 'reports',
          message: { errors: 'InvalidRecordData' }
        }, status: :unprocessable_entity
    end

    @record = Actions::RecordSaver.call(record_params.to_h)

    if @record.present?
      render json: @record, status: :created, location: survivor_records_path(@record)
    end
  end

  private

  def record_params
    params.require(:data).require(:attributes).permit(:survivor_id, :by_survivor_id, :kind)
  end
end
