App.cable.subscriptions.create "IotDataChannel",
  connected: ->
    console.log "Connection to Server Established"
    @perform 'stream_sensor_data'

  disconnected: ->
    console.log "Websocket connection lost"

  received: (data) ->
    console.log(data)
    @update_dom(data['temp'], data['humidity'])

  update_dom: (temp, humidity) ->
    document.write temp
    document.write humidity
