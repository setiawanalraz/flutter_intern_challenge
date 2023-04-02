import 'dart:async';

import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sensors_plus/sensors_plus.dart';
import 'package:intern_flutter_challenge/style/style.dart';
import 'package:intern_flutter_challenge/widgets/my_appbar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // date and time
  String formattedTime = intl.DateFormat('kk:mm:ss').format(DateTime.now());
  String formattedDate =
      intl.DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
  // ignore: unused_field
  late Timer _timer;

  void _update() {
    setState(() {
      formattedTime = intl.DateFormat('kk:mm:ss').format(DateTime.now());
      formattedDate =
          intl.DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    });
  }

  // geolocator
  bool serviceStatus = false;
  bool hasPermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    checkGPS();

    super.initState();
    _timer =
        Timer.periodic(const Duration(milliseconds: 500), (timer) => _update());

    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          setState(() {
            _gyroscopeValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
    _streamSubscriptions.add(
      magnetometerEvents.listen(
        (MagnetometerEvent event) {
          setState(() {
            _magnetometerValues = <double>[event.x, event.y, event.z];
          });
        },
      ),
    );
  }

  checkGPS() async {
    serviceStatus = await Geolocator.isLocationServiceEnabled();
    if (serviceStatus) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          debugPrint('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          debugPrint("'Location permissions are permanently denied");
        } else {
          hasPermission = true;
        }
      } else {
        hasPermission = true;
      }

      if (hasPermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      debugPrint("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint(position.longitude.toString());
    debugPrint(position.latitude.toString());

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });
  }

  @override
  void dispose() {
    super.dispose();
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  // sensor_plus
  List<double>? _accelerometerValues;
  List<double>? _gyroscopeValues;
  List<double>? _magnetometerValues;
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  // device_info
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo? androidInfo;
  Future<AndroidDeviceInfo> getInfo() async {
    return await deviceInfo.androidInfo;
  }

  @override
  Widget build(BuildContext context) {
    final accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    final magnetometer =
        _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();

    return Scaffold(
      appBar: const MyAppBar(appBarTitle: "Droid Device Info"),
      body: FutureBuilder<AndroidDeviceInfo>(
        future: getInfo(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          return ListView(
            children: ListTile.divideTiles(
              context: context,
              tiles: [
                ListTile(
                  leading: const Icon(
                    Icons.access_time,
                    color: Colors.brown,
                  ),
                  title: Text("Time now", style: brown),
                  subtitle: Text(formattedTime.toString(), style: brown),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(
                    Icons.date_range,
                    color: Colors.blue,
                  ),
                  title: Text("Date now", style: blue),
                  subtitle: Text(formattedDate.toString(), style: blue),
                  onTap: () {},
                ),

                // Accelerometer Sensor
                ListTile(
                  leading: const Icon(
                    Icons.speed_sharp,
                    color: Colors.red,
                  ),
                  title: Text("Accelerometer Sensor", style: red),
                  subtitle:
                      Text("${data?.hardware}, $accelerometer", style: red),
                  onTap: () {},
                ),

                // Gyroscope Sensor
                ListTile(
                  leading: const Icon(
                    Icons.play_for_work_outlined,
                    color: Colors.teal,
                  ),
                  title: Text("Gyroscope Sensor", style: teal),
                  subtitle: Text("${data?.hardware}, $gyroscope", style: teal),
                  onTap: () {},
                ),

                // Magnetometer Sensor
                ListTile(
                  leading: const Icon(
                    Icons.settings_input_component_sharp,
                    color: Colors.purple,
                  ),
                  title: Text("Magnetometer Sensor", style: purple),
                  subtitle:
                      Text("${data?.hardware}, $magnetometer", style: purple),
                  onTap: () {},
                ),

                // GPS Coordinate
                ListTile(
                  leading: const Icon(
                    Icons.pin_drop,
                    color: Colors.amber,
                  ),
                  title: Text("GPS Coordinate", style: amber),
                  subtitle: (lat != '')
                      ? Text("$lat, $long", style: amber)
                      : const LinearProgressIndicator(),
                  onTap: () {},
                ),

                // Battery Level
                StreamBuilder<AndroidBatteryInfo?>(
                  stream: BatteryInfoPlugin().androidBatteryInfoStream,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    return ListTile(
                      leading: const Icon(
                        Icons.battery_std,
                        color: Colors.green,
                      ),
                      title: Text("Battery Level", style: green),
                      subtitle: Text(
                        "${(data?.batteryLevel)} %",
                        style: green,
                      ),
                      onTap: () {},
                    );
                  },
                ),
              ],
            ).toList(),
          );
        },
      ),
    );
  }
}
