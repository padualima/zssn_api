module Actions
  class RecordSaver < ApplicationService
    def initialize(record_data)
      raise ArgumentError unless record_data.is_a?(Hash)
      @record_data = record_data
      @record_strategy = define_strategy(record_data[:kind])
      @logger = Rails.logger
    end

    def call
      return if @record_strategy.nil?

      @record_strategy.save(@record_data, @logger)
    end

    private

    def define_strategy(k)
      raise ArgumentError unless k.in?(Record.kinds.keys)

      if k == Record.kinds.keys[0]
        Actions::RecordStrategy::Infect.new()
      elsif k == Record.kinds.keys[1]
        Actions::RecordStrategy::Recover.new()
      end
    end
  end
end
