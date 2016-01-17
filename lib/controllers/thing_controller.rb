require_relative 'log_controller'
require_relative 'network_controller'

# Main controller. Handles interfaces between the network, local model, and GPIO 
# controller. It also handles logging
class ThingController
  attr_reader :log_controller,
              :network_controller

  def initialize thing_name, aws_iot_subdomain
    @thing_name = thing_name
    @aws_iot_subdomain = aws_iot_subdomain
    notify_start
  end

  def notify_start
    log_controller.log "------------------------------"
    log_controller.log "STARTING Thing CLIENT APP for #{@thing_name}"
    log_controller.log "------------------------------"
  end

  def subscribe_for_updates
    network_controller.subscribe_for_updates @thing_name do |thing|
      thing_changed_on_server(thing)
    end
  end

  def thing_changed_on_server message
    if @thing.nil? || message["state"] != @thing["state"]
      @thing = message
      # submit_change_request_for_server(thing)
      log_controller.log "thing changed on server. submitting change request: " + @thing.to_s
    else
      log_controller.log "thing changed on server, but already the same here. no change."
    end
  end

  def log_controller
    @log_controller ||= LogController.new("../logs/iotthing_#{Time.now.strftime('%Y-%m-%d')}.log")
  end

  def network_controller
    @network_controller ||= NetworkController.new(log_controller, @aws_iot_subdomain)
  end
end
