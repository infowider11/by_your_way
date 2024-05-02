import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../constants/error_constants.dart';
import '../constants/global_keys.dart';
import '../constants/my_colors.dart';
import '../constants/my_image_url.dart';
import '../functions/print_function.dart';
import '../functions/showCustomDialog.dart';
import '../services/custom_navigation_services.dart';
import '../services/google_map_services.dart';
import '../widget/input_text_field_widget.dart';
import '../widget/location_permission.dart';
import '../widget/round_edged_button.dart';
import '../widget/show_snackbar.dart';



class MyLocationProvider extends ChangeNotifier{
  double latitude = 0;
  double longitude = 0;
  String? addressString;
  Stream<Position>? data;
  // ValueNotifier<QrCheckStatus> qrCheckStatusNotifier = ValueNotifier(QrCheckStatus.fetchingLocation);

  updateLatLong()async{
    print('sfklsfkls klsdf');
    try{
      await Geolocator.requestPermission();
      var position = await Geolocator.getCurrentPosition(
        // forceAndroidLocationManager: true,
      );
      print('the position is $position');
      latitude = position.latitude;
      longitude = position.longitude;
      await updateAddress();
    }catch(e){
      updateAddress();
    }

  }


  initializePositionStream()async{
    print('intiialize position stream is called');
    if(data==null){
      data = Geolocator.getPositionStream(locationSettings: LocationSettings(accuracy: LocationAccuracy.medium,distanceFilter: 5));
      data!.listen((event) {
        try{
          // print('Updating user location ${latitude}.... ${longitude}....${event}');
          latitude = event.latitude;
          longitude = event.longitude;
          notifyListeners();
        }catch(e){
          // print('Error in catch block unable to fetch the location....$e');
        }
      });
    }else{
      // print('location stream is already initialized');
    }
  }



  updateAddress()async{

    if(addressString!=null || addressString==""){
      addressString = null;
      notifyListeners();
    }

    print('About to determine position..d.');
    if(data==null || latitude==0){
      await initializePositionStream();
      await Future.delayed(Duration(seconds: 2));
      updateAddress();
      return;
    }

    if(await Permission.location.status!=PermissionStatus.granted){
      showSnackbar('permission not given..sdkjhfdks');
      return;
    }


    addressString = await getAddressFromLatLng(latitude,longitude);
    if(addressString!.contains(MyErrorConstants.noAddressFound)){
      // showSnackbar('Error is here code #152344 $latitude....$longitude....retryingg....._${addressString}_..');
      addressString = null;
      if(latitude==0){
        await updateLatLong();
        showSnackbar('Now Lat Long are $latitude...$longitude');
      }

    }else{

    }


    print('About to determine address...done');
    notifyListeners();

  }

  Future<String> getAddressFromLatLng(double? lat, double? lang) async {
    if (lat == null || lang == null) return "";

    try{

      print('Getting address string$lat');
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lang);
      myCustomPrintStatement("address ---------------${placemarks[0].toString()}");
      String addressString = '';
      if(placemarks[0].name==placemarks[0].subLocality){
        // addressString = '${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode} ${placemarks[0].country}';
        addressString = ' ${placemarks[0].locality}';
      }else{
        addressString = ' ${placemarks[0].locality}';
        // addressString = '${placemarks[0].street}, ${placemarks[0].name}, ${placemarks[0].subLocality}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea}, ${placemarks[0].postalCode} ${placemarks[0].country}';
      }


      return addressString;

    }catch(err){
      myCustomPrintStatement('err from reverseGeocoding()-----------$err');


      return '${MyErrorConstants.noAddressFound} $lat.....$lang';
    }

  }

  Future<LatLng?> showCustomLocationPicker() async {
    TextEditingController searchByLocationController = TextEditingController();
    FocusNode searchByLocationFocusNode = FocusNode();
    CameraPosition? previousCameraPosition;
    ValueNotifier<LatLng> latLngValueNotifier =
    ValueNotifier(LatLng(latitude, longitude));
    GoogleMapController? googleMapController;
    ValueNotifier<List> predictions = ValueNotifier([]);
    return showCustomDialog<LatLng>(
      height: 500,
      child: Container(
        child: Stack(
            children:[
              Column(
                children: [
                  ValueListenableBuilder(
                      valueListenable: predictions,
                      builder: (context, predictionsValue, child) {
                        return InputTextFieldWidget(
                            controller: searchByLocationController,
                            focusNode: searchByLocationFocusNode,
                            // height: 50,
                            headingText: null,
                            // filledColor: MyColors.whiteColor,
                            hintText: 'Detecting location...',
                            // textFieldBorderColor: MyColors.whiteColor,
                            contentPaddingVertical: 8,
                            onTap: ()async{
                              predictions.notifyListeners();

                            },
                            onChanged: (val) async {
                              print('sfadsfsdfsd');
                              // Image image = Image(image: AssetImage(MyImagesUrl.homeLocationPinRed));
                              // ByteData data = await rootBundle.load(MyImagesUrl.homeLocationPinRed);
                              // myCustomLogStatements('sdfksjflk ${ data.buffer.asUint8List()}');
                              // return;
                              predictions.value =
                              await GoogleMapServices.getPlacePridiction(val);
                              print('the results are ${predictions.value}');
                            },
                            prefix: Image.asset(
                              MyImagesUrl.location,
                              color: MyColors.primaryColor,
                              scale: 5,
                            ),
                            suffix: predictionsValue.isEmpty &&  searchByLocationFocusNode.hasFocus==false
                                ? null
                                : IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                predictions.value.clear();
                                predictions.notifyListeners();
                                searchByLocationController.clear();
                              },
                            ));
                      }),
                  Expanded(
                    child: ValueListenableBuilder(
                      valueListenable: latLngValueNotifier,
                      builder: (_, latLngValue, __) => Stack(
                        children: [
                          GoogleMap(
                            onCameraMove: (CameraPosition position) async {
                              if (previousCameraPosition != position) {
                                //     myCustomPrintStatement(
                                //         "current move value $position");
                                latLngValueNotifier.value =
                                    position.target;
                                // latLngValueNotifier.value.latitude=argument.latitude;
                                // onMapScrolled(
                                //         context: context, argument: position.target);
                                //     previousCameraPosition = position;
                              }
                            },
                            onCameraIdle: ()async {
                              myCustomPrintStatement("current not move value ");
                              // String adrress = await GoogleMapServices.getAddressFromLatLng(
                              //     latLngValueNotifier.value.latitude,
                              //     latLngValueNotifier.value.longitude);
                              // print('sdfklsflk $adrress....');
                            },
                            gestureRecognizers: {
                              Factory<OneSequenceGestureRecognizer>(
                                      () => EagerGestureRecognizer())
                            },
                            onMapCreated: (GoogleMapController controller) {
                              googleMapController = controller;

                            },
                            initialCameraPosition: CameraPosition(
                              target: latLngValueNotifier.value,
                              zoom: 12,
                            ),
                            rotateGesturesEnabled: true,
                            indoorViewEnabled: true,
                            compassEnabled: true,
                            zoomControlsEnabled: false,
                            // markers: markers.toSet(),
                          ),
                          Center(
                            child: Image.asset(
                              MyImagesUrl.location,
                              color: MyColors.primaryColor,
                              scale: 5,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: IconButton(
                              onPressed: () {
                                getGPS(context: MyGlobalKeys.navigatorKey.currentContext!).then((value) {
                                  // createSitterProvider.latLngValueNotifier.value =
                                  //     LatLng(
                                  //   double.parse(value!['lat']),
                                  //   double.parse(
                                  //     value['lng'],
                                  //   ),
                                  // );
                                  myCustomPrintStatement(
                                      "Current location lat lang ${double.parse(value!['lat'])} -----${double.parse(
                                        value['lng'],
                                      )}");
                                  googleMapController!
                                      .animateCamera(CameraUpdate.newLatLng(LatLng(
                                    double.parse(value!['lat']),
                                    double.parse(
                                      value['lng'],
                                    ),
                                  )));
                                  // onMapScrolled(
                                  //     context: context,
                                  //     argument: LatLng(
                                  //       double.parse(value!['lat']),
                                  //       double.parse(
                                  //         value['lng'],
                                  //       ),
                                  //     ));
                                });
                              },
                              icon: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: MyColors.whiteColor,
                                ),
                                padding: const EdgeInsets.all(4),
                                child: const Icon(
                                  Icons.my_location_sharp,
                                  color: MyColors.bluishColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  RoundEdgedButton(text: 'Confirm', onTap: (){
                    CustomNavigation.pop(MyGlobalKeys.navigatorKey.currentContext!, latLngValueNotifier.value);
                  },),
                ],
              ),
              Positioned(
                top: 65,
                // left: 16,right:16,
                child: ValueListenableBuilder(
                    valueListenable: predictions,
                    builder: (c, p, w) {
                      if (p.length == 0) {
                        return Container();
                      }
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: MyColors.primaryColor),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        // height: 300,
                        constraints: BoxConstraints(
                          // minHeight: 100,
                          maxHeight: 220,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int i = 0; i < p.length; i++)
                                      GestureDetector(
                                        onTap: () async {
                                          searchByLocationController
                                              .text = p[i]['description'];
                                          String placeId = p[i]['place_id'];
                                          predictions.value = [];
                                          FocusScope.of(MyGlobalKeys.navigatorKey.currentContext!)
                                              .requestFocus(FocusNode());
                                          var address =
                                          await GoogleMapServices.getLatLngByPlaceId(
                                              placeId);

                                          latLngValueNotifier.value =
                                              LatLng(
                                                  address['result']['geometry']
                                                  ['location']['lat'],
                                                  address['result']['geometry']
                                                  ['location']['lng']);
                                          googleMapController!
                                              .animateCamera(
                                            CameraUpdate.newLatLng(
                                              LatLng(
                                                  address['result']['geometry']
                                                  ['location']['lat'],
                                                  address['result']['geometry']
                                                  ['location']['lng']),
                                            ),
                                          );
                                          // pickupLocation['lng'] =address['result']['geometry']['location']['lng'] ;
                                          // _focusDrop.requestFocus();
                                        },
                                        child: Container(
                                          width: MediaQuery.of(MyGlobalKeys.navigatorKey.currentContext!).size.width,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom:
                                              // i == p.length - 1
                                              //
                                              //     ? BorderSide.none
                                              //     :
                                              const BorderSide(
                                                color: MyColors.primaryColor,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            p[i]['description']
                                            // + '${p.length}'
                                            ,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                // searchByLocationController
                                //     .text = 'hello';
                                predictions.value = [];
                                FocusScope.of(MyGlobalKeys.navigatorKey.currentContext!)
                                    .requestFocus(FocusNode());

                                var temp =
                                await Provider.of<MyLocationProvider>(
                                    MyGlobalKeys.navigatorKey.currentContext!,
                                    listen: false)
                                    .showCustomLocationPicker();
                                if(temp!=null){
                                  latLngValueNotifier.value = temp;
                                }
                                print('the lat long is ${latLngValueNotifier.value}');
                                searchByLocationController.text =
                                await GoogleMapServices.getAddressFromLatLng(
                                    latLngValueNotifier.value.latitude,
                                    latLngValueNotifier.value.longitude);
                                googleMapController!.animateCamera(
                                  CameraUpdate.newLatLng(latLngValueNotifier.value),
                                );
                                // pickupLocation['lng'] =address['result']['geometry']['location']['lng'] ;
                                // _focusDrop.requestFocus();
                              },
                              child: Container(
                                width:
                                MediaQuery.of(MyGlobalKeys.navigatorKey.currentContext!)
                                    .size
                                    .width,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                      // i == p.length - 1
                                      //     ? BorderSide.none
                                      //     :
                                      const BorderSide(
                                        color: MyColors.primaryColor,
                                      ),
                                      top: BorderSide(color: MyColors.primaryColor)
                                  ),
                                ),
                                child: Text(
                                  'Pin Location On Map',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                predictions.value = [];
                                FocusScope.of(MyGlobalKeys.navigatorKey.currentContext!)
                                    .requestFocus(FocusNode());

                                var locationProvider = Provider.of<MyLocationProvider>(
                                    MyGlobalKeys.navigatorKey.currentContext!,
                                    listen: false);
                                latLngValueNotifier.value = LatLng(
                                    locationProvider.latitude, locationProvider.longitude);

                                print('the lat long is ${latLngValueNotifier.value}');
                                searchByLocationController.text =
                                await GoogleMapServices.getAddressFromLatLng(
                                    latLngValueNotifier.value.latitude,
                                    latLngValueNotifier.value.longitude);
                                googleMapController!.animateCamera(
                                  CameraUpdate.newLatLng(latLngValueNotifier.value),
                                );
                                // pickupLocation['lng'] =address['result']['geometry']['location']['lng'] ;
                                // _focusDrop.requestFocus();
                              },
                              child: Container(
                                width:
                                MediaQuery.of(MyGlobalKeys.navigatorKey.currentContext!)
                                    .size
                                    .width,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(
                                      bottom:
                                      // i == p.length - 1
                                      //     ?
                                      BorderSide.none
                                    //     :
                                    // const BorderSide(
                                    //   color: MyColors.greenColor,
                                    // ),
                                  ),
                                ),
                                child: Text(
                                  'My Current Location',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ]
        ),
      ),
    );
  }
}