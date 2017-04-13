class IotDataChannel < ApplicationCable::Channel
  def subscribed
    stream_from "iot_data_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  # Sets up a UDP Server bound to 0.0.0.0:1234
  # When it receives data, the same is broadcasted
  # to `iot_data_channel`
  def stream_sensor_data
    require 'socket'
    require 'json'

    server = UDPSocket.new
    server.bind("0.0.0.0", 1234)

    Rails::logger.debug "UDP Server listening on 0.0.0.0:1234"

    Thread.start do
      loop do
        data, _client = server.recvfrom(1024) # data here is stringified JSON

        Rails::logger.debug "Received #{data}"

        data = JSON.parse(data)

        temp = data['temp']
        humidity = data['humidity']

        ActionCable.server.broadcast "iot_data_channel", temp: temp, humidity: humidity
      end
    end
  end
end
