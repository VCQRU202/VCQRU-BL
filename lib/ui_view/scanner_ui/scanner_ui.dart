import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vcqru_bl/ui_view/scanner_ui/scanner_api/scanner_code_api.dart';

import '../../providers_of_app/scanner_provider/scanner_provider.dart';
import '../../res/api_url/api_url.dart';
import '../../res/app_colors/Checksun_encry.dart';
import '../../res/app_colors/app_colors.dart';
import '../../res/custom_alert_msg/custom_alert_msg.dart';
import '../../res/shared_preferences.dart';
import '../../res/values/values.dart';
import '../code_check_history_ui/code_check_history.dart';
import 'drop_down_field_custom.dart';
import 'enter_code_check/code_check_succes_msg.dart';
import 'enter_code_check/enter_code_check_ui.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {


  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final appState = Provider.of<Scanner_provider>(context, listen: false);
    if (mounted) {
      appState.startScaning();
    }
    _handleLocationPermission1(appState);
  }
  Future<bool> _handleLocationPermission1(Scanner_provider appState) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text(
      //         'Location services are disabled. Please enable the services')));
      // errorDialog(
      //   context,
      //   "Location services are disabled. Please enable the services",
      //   icon: AlertDialogIcon.INFO_ICON,
      //   title:"",
      // );
      // warningDialog(
      //     context, "Location services are disabled. Please enable the services",
      //     positiveText: "Enable", positiveAction: () async {
      //   print("--------");
      //   await Geolocator.openLocationSettings().then((value) {
      //     print("------------------" + value.toString());
      //   });
      // }, neutralAction: () async {
      //   print("--------");
      // });

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
            Text('Location permissions are denied. Enable to Continue')));
        // errorDialog(
        //   context,
        //   "Location permissions are denied. Enable to Continue",
        //   icon: AlertDialogIcon.INFO_ICON,
        //   title: "",
        // );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      // errorDialog(
      //   context,
      //   "Location permissions are permanently denied, we cannot request permissions.",
      //   icon: AlertDialogIcon.INFO_ICON,
      //   title: "",
      // );
      return false;
    }
    if (permission == LocationPermission.always) {
      //
      if (appState.lat.isEmpty || appState.long.isEmpty) {
        _getCurrentPosition(appState);
      }
    }
    if (permission == LocationPermission.whileInUse) {
      //
      if (appState.lat.isEmpty || appState.long.isEmpty) {
        _getCurrentPosition(appState);
      }
    }
    return true;
  }

  Future<void> _getCurrentPosition(Scanner_provider appState) async {
    final hasPermission = await _handleLocationPermission1(appState);

    if (!hasPermission) {
      Geolocator.openLocationSettings();
    }
    // return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      appState.updatePosition(position);
      _getAddressFromLatLng(appState);
    }).catchError((e) {});
  }

  Future<void> _getAddressFromLatLng(Scanner_provider appState) async {
    await placemarkFromCoordinates(
        appState.currentPosition.latitude, appState.currentPosition.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      // print(place.country);
      setState(() {
        print(appState.currentPosition!.longitude.toString());
        print(appState.currentPosition!.longitude.toString());
      });
      // print({_currentAddress, _currentPosition});
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<Scanner_provider>(context);
    final width = MediaQuery.of(context).size.width;
    final hieght = MediaQuery.of(context).size.height;
    return StreamBuilder<ConnectivityResult>(
      stream: Connectivity().onConnectivityChanged,
      builder: (context, snapshot) {
        return snapshot.data == ConnectivityResult.none
            ? Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 400,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 220,
                          height: 150,
                          margin: EdgeInsets.only(
                              top: 0, left: 10, bottom: 10, right: 10),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                AssetImage("assets/internet_error.png"),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Oops, No Internet Connection",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Container(
                    margin: EdgeInsets.only(
                        left: 30, right: 30, top: 10, bottom: 20),
                    child: Text(
                      "Make sure wifi or celluler data is tured on and then try again",
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    )),
              ],
            ),
          ),
        )
            : Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: hieght,
              width: width,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Expanded(
                          flex: 8,
                          child: Stack(
                            children: [
                              _buildQrView(context,appState),
                            ],
                          )),
                      Expanded(
                          flex: 2,
                          child: ListView(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                child:Text("13 Digit Code",style: TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 16
                                ),),
                              ),
                              GestureDetector(
                                onTap: (){
                                 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CodeCheckSuccessScreen()));
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EnterCodeCheck()));
                                   },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 55,
                                      padding: EdgeInsets.only(left: 10,top: 6),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: 1,color: AppColor.otp_color),
                                          borderRadius: BorderRadius.all(Radius.circular(2))
                                      ),
                                      margin: EdgeInsets.only(left: Sizes.ELEVATION_16, right: Sizes.ELEVATION_16),
                                      child: DropDownTextField(
                                        hintText: "Enter 13 Digit Code",
                                        icon: Icons.person_pin,
                                        enable: false,
                                        color: AppColor.textfield_border_color,
                                        color_text:AppColor.black_color ,
                                        keyboardtype: TextInputType.text,
                                        inputformetter: [],
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 10,
                                      width: 100,
                                      margin: EdgeInsets.only(top: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0), //Use this code to make rounded corners
                                        color: const Color(0xffCCCCCC),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(top: 50, left: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Cutout(
                                  color: Colors.white,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 80),
                                  child: Text(
                                    "Scan QR",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQrView(BuildContext context,Scanner_provider appState) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 || MediaQuery.of(context).size.height < 400)
        ? 170.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: appState.qrKey,
      overlayMargin: EdgeInsets.only(top: 0),
      onQRViewCreated: _onQRViewCreated,
      formatsAllowed: [BarcodeFormat.qrcode],
      overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 6,
          borderLength: 80,
          borderWidth: 4,
          cutOutBottomOffset: 2,
          overlayColor: const Color.fromRGBO(0, 0, 0, 100),
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  Future _qrScanner(Scanner_provider  scanner_provider,qrdata) async {
    scanner_provider.controller!.pauseCamera();

    if (qrdata != null) {
      String qs = qrdata.replaceAll(new RegExp(r'[^0-9]'), '');
      print("-------main-------" + qs);
      if (qs.toString().length == 13) {
        String scanCode1 = qs.toString().replaceAll(RegExp('-'), '');
        scanner_provider.updateScanDetails(scanCode1);
        print("------" + qs.toString().replaceAll(RegExp('-'), ''));
        // ClickSubmitToVerify(scanCode1);
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>QRLoadingScreen(
              code: scanCode1,
              lat: scanner_provider.lat,
              long: scanner_provider.long,
            )));
      } else {
        // errorDialog(
        //   context,
        //   "Not Read Properly",
        //   icon: AlertDialogIcon.INFO_ICON,
        //   title: "Invalid Code , Please try Again",
        // );
        scanner_provider.startCemra();
        toastRedC("Invalid Code , Please try Again");
      }
    } else {
      scanner_provider.startCemra();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    final appState = Provider.of<Scanner_provider>(context, listen: false);
    appState.setQRViewController(controller);
    controller.scannedDataStream.listen((scanData) {
      // appState.updateResult(scanData);
      print(scanData.code);
      _qrScanner(appState,scanData!.code);
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  void _presentBottomSheetGreen(
      BuildContext context,
      String? code1,
      String? code2,
      String? date,
      String? message,
      String? company,
      String? statusCheck) {
    if (message == null) {
      message = "";
    }
    if (statusCheck == "Success" || statusCheck == null) {
      statusCheck = "Transaction Success";
    } else {
      statusCheck = "Transaction Failed";
    }
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      isDismissible: false,
      builder: (context) => Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 0),
              Row(
                children: [
                  Expanded(
                    flex: 6, // 10%
                    child: Container(
                      width: double.infinity,
                      margin:
                      const EdgeInsets.only(left: 0, top: 10, right: 10),
                      child: const Text(
                        "Sagar Petroleums Pvt Ltd",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4, // 50%
                    child: Container(
                      width: double.infinity,
                      alignment: FractionalOffset.topRight,
                      margin: const EdgeInsets.only(left: 0, top: 0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: const Text(
                          "Status",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: Text(
                          statusCheck.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff35de08),
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Divider(
                  height: 1.5,
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: const Text(
                          "Company Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: Text(
                          company ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: const Text(
                          "Code",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: Text(
                          code1.toString() + code2.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Divider(
                  height: 1.5,
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: const Text(
                          "Enquiry Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff214363),
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: Text(
                          date.toString() == null ? "" : date.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Divider(
                  height: 1.5,
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(
                  message.toString(),
                  style: const TextStyle(
                      color: Colors.green,
                      fontStyle: FontStyle.normal,
                      fontSize: 12),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  //String data_Vlue = await SharedPrefHelper().get("dataVlue");
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ReportIssueHomePage(
                  //             code: code1,
                  //             code11: code2,
                  //             date: date,
                  //             msg: message)));
                },
                child: Center(
                  child: Container(
                    margin:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 40),
                    width: 200,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(3)),
                    child: const Text(
                      "Report Issue",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xfffdfdfd),
                          fontStyle: FontStyle.normal,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _presentBottomSheet(BuildContext context, String? code1, String? code2,
      String? date, String? message, String? company, String? statusCheck) {
    if (message == null) {
      message = "";
    }
    if (statusCheck == "Success" || statusCheck == null) {
      statusCheck = "Transaction Success";
    } else {
      statusCheck = "Transaction Failed";
    }
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      builder: (context) => Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 0),
              Row(
                children: [
                  Expanded(
                    flex: 6, // 10%
                    child: Container(
                      width: double.infinity,
                      margin:
                      const EdgeInsets.only(left: 0, top: 10, right: 10),
                      child: const Text(
                        "Sagar Petroleums Pvt Ltd",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.normal,
                            fontSize: 14),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4, // 50%
                    child: Container(
                      width: double.infinity,
                      alignment: FractionalOffset.topRight,
                      margin: const EdgeInsets.only(left: 0, top: 0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: const Text(
                          "Status",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: Text(
                          statusCheck.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Divider(
                  height: 1.5,
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: const Text(
                          "Company Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: Text(
                          company ?? "",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: const Text(
                          "Code",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: Text(
                          code1.toString() + code2.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(left: 0),
                        child: const Text(
                          "Enquiry Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff214363),
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: Text(
                          date.toString() == null ? "" : date.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontSize: 12),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Divider(
                  height: 1.5,
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(
                  message.toString(),
                  style: const TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.normal,
                      fontSize: 12),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  //String data_Vlue = await SharedPrefHelper().get("dataVlue");
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ReportIssueHomePage(
                  //             code: code1,
                  //             code11: code2,
                  //             date: date,
                  //             msg: message)));
                },
                child: Center(
                  child: Container(
                    margin:
                    const EdgeInsets.only(left: 20, top: 10, bottom: 40),
                    width: 200,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(3)),
                    child: const Text(
                      "Report Issue",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xfffdfdfd),
                          fontStyle: FontStyle.normal,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}

class Cutout extends StatelessWidget {
  const Cutout({
    Key? key,
    @required this.color,
    @required this.child,
  }) : super(key: key);

  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcOut,
      shaderCallback: (bounds) =>
          LinearGradient(colors: [color!], stops: [0.0]).createShader(bounds),
      child: child,
    );
  }
}
