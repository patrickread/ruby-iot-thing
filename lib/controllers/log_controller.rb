require 'logger'

class LogController
  attr_reader :log_message_proc,
              :logger,
              :file_path

  def initialize file_path
    @file_path = file_path
  end

  def log message
    log_message_proc.call message
  end

  private

  def logger
    @logger ||= Logger.new(file_path)
  end

  def log_message_proc
    @log_message_proc ||= Proc.new do |message|
      puts message
      logger.info message
    end
  end
end
