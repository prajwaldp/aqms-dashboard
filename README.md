# AQMS Dashboard

A realtime IoT Dashboard using ActionCable

## Usage

```
$ git clone ... && cd ...
$ bundle install
```

In one terminal run
```
$ rails server
```

In another terminal run
```
$ ./bin/fake_sensor
```

In production, this would be a script that connects to the UDP Server created within the Rails codebase and sends data to it in stringified JSON format

## Walkthrough

- There is only one route `pages_controller#dashboard`
- The `IotDataChannel` in `app/assets/channels` is the channel for sensor data
- When a client subscribes to `IotDataChannel`, the client is streamed data from `iot_data_channel`
- `IotDataChannel#stream_sensor_data` starts a UDP Server
    - It accepts data from clients (the fake sensor value generating program or a client running on a Raspberry Pi)
    - Keeps broadcasting data from the client to the `iot_data_channel` is a `Thread`

