import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:responsify/responsify.dart';
import 'package:testing/widget/GlobalSnackbar.dart';
import 'package:http/http.dart' as http;
import 'package:testing/widget/GlobalSnackbar.dart';

class AttendanceScreen extends StatefulWidget {
  final List userInfo;
  const AttendanceScreen({Key key, this.userInfo}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool checkedIn = false;
  bool checkedOut = false;
  String latitude = '';
  String longitude = '';
  double distanceBetween;
  String checkInTimeDone;
  String checkoutTimeDone;

  // ignore: missing_return
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      GlobalSnackBar.show(context, 'Please enable Your Location Service');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        GlobalSnackBar.show(context, 'Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      GlobalSnackBar.show(context,
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      setState(() {
        latitude = position.latitude.toString();
        longitude = position.longitude.toString();
      });
    } catch (e) {
      print(e);
    }
  }

  allowCheckin() async {
    // comes in meters
    distanceBetween = GeolocatorPlatform.instance.distanceBetween(
        double.parse(latitude),
        double.parse(longitude),
        double.parse(widget.userInfo[0].latitude),
        double.parse(widget.userInfo[0].longitude));

    print(distanceBetween);
    if (distanceBetween > 500) {
      // force checkin
      showModalBottomSheet(
          context: context,
          builder: (_) => Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Text(' Are You Sure You Want to Check In ? ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Since You are out of your branch radius you are now requesting Force CheckIn . Please Confirm your selection below. Your current location will be logged in for internal monitoring purpose',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              TimeOfDay checkInTime =
                                  TimeOfDay(hour: 07, minute: 0);

                              TimeOfDay nowTime = TimeOfDay.now();

                              double _doubleCheckInTime =
                                  checkInTime.hour.toDouble() +
                                      (checkInTime.minute.toDouble() / 60);
                              double _doubleNowTime = nowTime.hour.toDouble() +
                                  (nowTime.minute.toDouble() / 60);

                              double _timeDiff =
                                  _doubleCheckInTime - _doubleNowTime;

                              double _hr = _timeDiff.truncate().toDouble();

                              print(_hr);

                              if (_hr < 0 || _hr > 0 || _hr == 0) {
                                print('ok');
                                setState(() {
                                  checkedIn = true;
                                  checkInTimeDone =
                                      TimeOfDay.now().hour.toString() +
                                          ':' +
                                          TimeOfDay.now().minute.toString() +
                                          ':' +
                                          DateTime.now().second.toString();
                                });
                                Navigator.pop(context);
                                sendtoServer();
                                final snackBar = SnackBar(
                                  content: const Text('Successfully Done'),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                Navigator.pop(context);
                                final snackBar = SnackBar(
                                  content: const Text(
                                      'Some Internal Error Occured !'),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text('Go For Check In')),
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'))
                      ],
                    )
                  ],
                ),
              ));
    } else {
      // normal checkin

      TimeOfDay checkInTime = TimeOfDay(hour: 07, minute: 0);

      TimeOfDay nowTime = TimeOfDay.now();

      double _doubleCheckInTime =
          checkInTime.hour.toDouble() + (checkInTime.minute.toDouble() / 60);
      double _doubleNowTime =
          nowTime.hour.toDouble() + (nowTime.minute.toDouble() / 60);

      double _timeDiff = _doubleCheckInTime - _doubleNowTime;

      double _hr = _timeDiff.truncate().toDouble();

      print(_hr);

      if (_hr > 0) {
        print('ok');
        setState(() {
          checkedIn = true;
          checkInTimeDone = TimeOfDay.now().hour.toString() +
              ' - ' +
              TimeOfDay.now().minute.toString();
        });

        final snackBar = SnackBar(
          content: const Text('Successfully Done'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: const Text('Error !'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  allowCheckout() async {
    // comes in meters
    distanceBetween = GeolocatorPlatform.instance.distanceBetween(
        double.parse(latitude),
        double.parse(longitude),
        double.parse(widget.userInfo[0].latitude),
        double.parse(widget.userInfo[0].longitude));

    print(distanceBetween);
    if (distanceBetween > 500) {
      // force checkin
      showModalBottomSheet(
          context: context,
          builder: (_) => Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Text(' Are You Sure You Want to Check Out ? ',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Since You are out of your branch radius you are now requesting Force Checkout . Please Confirm your selection below. Your current location will be logged in for internal monitoring purpose',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              TimeOfDay checkInTime =
                                  TimeOfDay(hour: 16, minute: 0);

                              TimeOfDay nowTime = TimeOfDay.now();

                              double _doubleCheckInTime =
                                  checkInTime.hour.toDouble() +
                                      (checkInTime.minute.toDouble() / 60);
                              double _doubleNowTime = nowTime.hour.toDouble() +
                                  (nowTime.minute.toDouble() / 60);

                              double _timeDiff =
                                  _doubleCheckInTime - _doubleNowTime;

                              double _hr = _timeDiff.truncate().toDouble();

                              print(_hr);

                              if (_hr > 0 || _hr < 0 || _hr == 0) {
                                print('ok');
                                setState(() {
                                  checkedOut = true;
                                  checkoutTimeDone =
                                      TimeOfDay.now().hour.toString() +
                                          ':' +
                                          TimeOfDay.now().minute.toString() +
                                          ':' +
                                          DateTime.now().second.toString();
                                });
                                Navigator.pop(context);
                                sendtoServer();
                                final snackBar = SnackBar(
                                  content: const Text('Successfully Done'),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                Navigator.pop(context);
                                final snackBar = SnackBar(
                                  content: const Text(
                                      'Sorry Some Internal Error Occured!'),
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text('Go For Check Out')),
                        ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'))
                      ],
                    )
                  ],
                ),
              ));
    } else {
      // normal checkin

      TimeOfDay checkInTime = TimeOfDay(hour: 16, minute: 0);

      TimeOfDay nowTime = TimeOfDay.now();

      double _doubleCheckInTime =
          checkInTime.hour.toDouble() + (checkInTime.minute.toDouble() / 60);
      double _doubleNowTime =
          nowTime.hour.toDouble() + (nowTime.minute.toDouble() / 60);

      double _timeDiff = _doubleCheckInTime - _doubleNowTime;

      double _hr = _timeDiff.truncate().toDouble();

      print(_hr);

      if (_hr > 0 || _hr < 0 || _hr == 0) {
        setState(() {
          checkedOut = true;
          checkoutTimeDone = TimeOfDay.now().hour.toString() +
              ' - ' +
              TimeOfDay.now().minute.toString();
        });
        sendtoServer();

        final snackBar = SnackBar(
          content: const Text('Successfully Done'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final snackBar = SnackBar(
          content: const Text('Sorry! Some Internal Error Occured'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  Future sendtoServer() async {
    String baseUrl =
        "https://onlinefamilypharmacy.com/mobileapplication/salesmanapp/attendance.php";

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formattedDate = formatter.format(now);

    Map<String, dynamic> data = {
      'familyid': widget.userInfo[0].id,
      'date': formattedDate,
      'time_in': checkInTimeDone,
      'time_out': checkoutTimeDone,
      'workingin': widget.userInfo[0].workingin,
      'branchlocationlatitude': widget.userInfo[0].latitude,
      'branchlocationlongitude': widget.userInfo[0].longitude,
      'employeecurrentlocationlatitude': latitude,
      'employeecurrentlocationlongitude': longitude,
      'alreadyCheckedIn': 1,
    };

    var response = await http.post(Uri.parse(baseUrl), body: json.encode(data));
    print(data);
    print(response.body.toString());
  }

  @override
  void initState() {
    _determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _determinePosition();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Mark Your Attendance'),
        centerTitle: true,
      ),
      body: ResponsiveUiWidget(
        targetOlderComputers: false,
        builder: (context, deviceinfo) {
          if (deviceinfo.deviceTypeInformation ==
                  DeviceTypeInformation.TABLET &&
              deviceinfo.orientation == Orientation.landscape) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[300]),
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Employee Name - ${widget.userInfo[0].employeename}'),
                            Text(
                                'Employee Branch - ${widget.userInfo[0].workingin}'),
                            Text('Latitude - ${widget.userInfo[0].latitude}'),
                            Text('Longitude - ${widget.userInfo[0].longitude}'),
                            Text('Working Hours - 7 AM - 4 PM'),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width -
                            MediaQuery.of(context).size.width / 1.5,
                        margin: EdgeInsets.only(left: 100),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('View Presentes'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                child: Text('View Absentes'),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black)))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: DataTable(
                      columns: [
                        DataColumn(
                            label: Text(
                          'Check In Time',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text('Check Out Time',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold))),
                      ],
                      rows: [
                        DataRow(cells: [
                          // ignore: unnecessary_brace_in_string_interps
                          DataCell(checkInTimeDone == null
                              ? Text('Not Checked In')
                              : Text('${checkInTimeDone}')),
                          DataCell(checkoutTimeDone == null
                              ? Text('Not Checked Out')
                              : Text('${checkoutTimeDone}')),
                        ]),
                        DataRow(cells: [
                          // ignore: unnecessary_brace_in_string_interps
                          DataCell(
                            ElevatedButton(
                                onPressed: () {
                                  allowCheckin();
                                },
                                child: Text('Check In'),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black))),
                          ),
                          DataCell(ElevatedButton(
                              onPressed: () {
                                if (checkedIn == true) {
                                  allowCheckout();
                                } else {
                                  final snackBar = SnackBar(
                                    // content: const Text('Sorry You are not at your branch ! Please Try again after visiting the branch'),
                                    content: const Text('Check In First'),
                                  );

                                  // Find the ScaffoldMessenger in the widget tree
                                  // and use it to show a SnackBar.
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              child: Text('Check Out'),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.black)))),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (deviceinfo.deviceTypeInformation ==
                  DeviceTypeInformation.TABLET &&
              deviceinfo.orientation == Orientation.portrait) {
            return Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[300]),
                        padding: EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Employee Name - ${widget.userInfo[0].employeename}'),
                            Text(
                                'Employee Branch - ${widget.userInfo[0].workingin}'),
                            Text('Latitude - ${widget.userInfo[0].latitude}'),
                            Text('Longitude - ${widget.userInfo[0].longitude}'),
                            Text('Working Hours - 7 AM - 4 PM'),
                          ],
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width -
                              MediaQuery.of(context).size.width / 1.7,
                          margin: EdgeInsets.only(left: 50),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('View Presentes'),
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black)),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text('View Absentes'),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.black)))
                            ],
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  DataTable(
                    columns: [
                      DataColumn(
                          label: Text('Check In Time',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Check Out Time',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                    rows: [
                      DataRow(cells: [
                        // ignore: unnecessary_brace_in_string_interps
                        DataCell(checkInTimeDone == null
                            ? Text('Not Checked In')
                            : Text('${checkInTimeDone}')),
                        DataCell(checkoutTimeDone == null
                            ? Text('Not Checked Out')
                            : Text('${checkoutTimeDone}')),
                      ]),
                      DataRow(cells: [
                        // ignore: unnecessary_brace_in_string_interps
                        DataCell(
                          ElevatedButton(
                              onPressed: () {
                                allowCheckin();
                              },
                              child: Text('Check In'),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black))),
                        ),
                        DataCell(ElevatedButton(
                            onPressed: () {
                              if (checkedIn == true) {
                                allowCheckout();
                              } else {
                                final snackBar = SnackBar(
                                  // content: const Text('Sorry You are not at your branch ! Please Try again after visiting the branch'),
                                  content: const Text('Check In First'),
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text('Check Out'),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)))),
                      ]),
                    ],
                  ),
                ],
              ),
            );
          } else if (deviceinfo.deviceTypeInformation ==
              DeviceTypeInformation.MOBILE) {
            return Container(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[300]),
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'Employee Name - ${widget.userInfo[0].employeename}'),
                        Text(
                            'Employee Branch - ${widget.userInfo[0].workingin}'),
                        Text('Latitude - ${widget.userInfo[0].latitude}'),
                        Text('Longitude - ${widget.userInfo[0].longitude}'),
                        Text('Working Hours - 7 AM - 4 PM'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  DataTable(
                    columns: [
                      DataColumn(
                          label: Text('Check In Time',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Check Out Time',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold))),
                    ],
                    rows: [
                      DataRow(cells: [
                        // ignore: unnecessary_brace_in_string_interps
                        DataCell(checkInTimeDone == null
                            ? Text('Not Checked In')
                            : Text('   ${checkInTimeDone}   ')),
                        DataCell(checkoutTimeDone == null
                            ? Text('Not Checked Out')
                            : Text('              ${checkoutTimeDone}')),
                      ]),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            allowCheckin();
                          },
                          child: Text('Check In'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black))),
                      ElevatedButton(
                          onPressed: () {
                            if (checkedIn == true) {
                              allowCheckout();
                            } else {
                              final snackBar = SnackBar(
                                content: const Text('Check In First'),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Text('Check Out'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black)))
                    ],
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Text('Not Supported'),
          );
        },
      ),
    );
  }
}
