require 'rubygems'

gem 'mqtt'
require 'mqtt'
require 'json'

class NetworkController
  attr_accessor :log_controller

  def initialize log_controller, aws_iot_subdomain
    @log_controller = log_controller
    @aws_iot_subdomain = aws_iot_subdomain
  end

  def subscribe_for_updates thing_name, &thing_changed_block
    client = mqtt_client

    log_controller.log "Connecting to #{thing_name}"
    client.connect do |client|
      log_controller.log "Connected to #{thing_name}"

      # this will loop until a message is received
      client.get("$aws/things/#{thing_name}/shadow/update") do |topic, message|
        log_controller.log "#{topic}: #{message}"
        message_json = JSON.parse(message)
        thing_changed_block.call message_json
      end
    end
  end

  def mqtt_client
    client = MQTT::Client.new
    client.host = "#{@aws_iot_subdomain}.iot.us-east-1.amazonaws.com"
    client.port = 8883
    client.ssl = true
    client.cert_file = '../certs/cert.pem'
    client.key_file  = '../certs/privateKey.pem'
    client.ca_file   = '../certs/rootCA.pem'
    client
  end
end
