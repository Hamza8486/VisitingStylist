import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stylish_app/app_module/stylish_home/controller/stylish_controller.dart';
import 'package:stylish_app/util/theme.dart';
import 'package:stylish_app/widgets/app_text.dart';

class MapWithPolyline extends StatefulWidget {

  @override
  _MapWithPolylineState createState() => _MapWithPolylineState();
}

class _MapWithPolylineState extends State<MapWithPolyline> {

  Map<PolylineId, Polyline> polylines = {};
   GoogleMapController ? mapController;
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyAysRadDCKNl8GCE25tLN8bTOe2Y9HoLCE";
  LatLng startLocation = LatLng(double.parse(Get.put(StylishController()).latStart.value), double.parse(Get.put(StylishController()).lngStart.value));
  LatLng endLocation = LatLng(double.parse(Get.put(StylishController()).latEnd.value), double.parse(Get.put(StylishController()).lngEnd.value));
  double distance = 0.0;
  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }
    print(totalDistance);

    setState(() {
      distance = totalDistance;
    });
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: AppColor.primaryColor,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {
      _markers.add(Marker(
        //add distination location marker
        markerId: MarkerId(endLocation.toString()),
        infoWindow: const InfoWindow(
          title: 'User Location',
          snippet: 'End of the route',
        ),
        position: endLocation, //position of marker
        icon:BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      _markers.add(Marker(
        //add distination location marker
        markerId: MarkerId(startLocation.toString()),

        position: startLocation, //position of marker
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure), //Icon for Marker
      ));


    });
  }
  late BitmapDescriptor myIcon;

  final List<Marker> _markers = <Marker>[];

  @override
  void initState() {
    super.initState();
   getDirections();

   setState(() {

   });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(

            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: false,
            initialCameraPosition: CameraPosition(
                target: LatLng(startLocation.latitude, startLocation.longitude), zoom: 12),
            polylines: Set<Polyline>.of(polylines.values),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              mapController?.setMapStyle(mapStyle);

            },
            markers: Set<Marker>.of(_markers),
          ),
          Positioned(
              top: Get.height * 0.06,
              left: Get.width * 0.03,
              child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColor.whiteColor.withOpacity(0.9),
                    child: Icon(
                      Icons.arrow_back,
                      color: AppColor.boldBlackColor,
                    ),
                  ))),
          Positioned(
              top: Get.height * 0.06,
              right: Get.width * 0.03,
              child:Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                  child: Row(
                    children: [
                      AppText(
                      title: "Total Distance : ",
                      color: AppColor.boldBlackColor,
                      fontFamily: AppFont.medium,
                      fontWeight: FontWeight.w600,
                      size: AppSizes.size_13),


                      AppText(
                          title: "${distance.toStringAsFixed(1)} Km",
                          color: AppColor.boldBlackColor,
                          fontFamily: AppFont.semi,
                          fontWeight: FontWeight.w700,
                          size: AppSizes.size_13),

                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
String mapStyle =
    '[{"elementType": "geometry","stylers": [{"color": "#f5f5f5"}]},{"elementType": "labels.icon","stylers": [{"visibility": "off"}]},{"elementType": "labels.text.fill","stylers": [{"color": "#616161"}]},{"elementType": "labels.text.stroke","stylers": [{"color": "#f5f5f5"}]},{"featureType": "administrative.land_parcel","elementType": "labels.text.fill","stylers": [{"color": "#bdbdbd"}]},{"featureType": "poi","elementType": "geometry","stylers": [{"color": "#eeeeee"}]},{"featureType": "poi","elementType": "labels.text.fill","stylers": [{"color": "#757575"}]},{"featureType": "poi.park","elementType": "geometry","stylers": [{"color": "#e5e5e5"}]},{"featureType": "poi.park",  "elementType": "labels.text.fill",  "stylers": [{"color": "#9e9e9e"}]},{"featureType": "road",  "elementType": "geometry",  "stylers": [{"color": "#ffffff"}]},{"featureType": "road.arterial",  "elementType": "labels.text.fill",  "stylers": [{"color": "#757575"}]},{"featureType": "road.highway",  "elementType": "geometry",  "stylers": [{"color": "#dadada"}]},{"featureType": "road.highway",  "elementType": "labels.text.fill",  "stylers": [{"color": "#616161"}]},{"featureType": "road.local",  "elementType": "labels.text.fill",  "stylers": [{"color": "#9e9e9e"}]},{"featureType": "transit.line",  "elementType": "geometry",  "stylers": [{"color": "#e5e5e5"}]},{"featureType": "transit.station",  "elementType": "geometry",  "stylers": [{"color": "#eeeeee"}]},{"featureType": "water",  "elementType": "geometry",  "stylers": [{"color": "#c9c9c9"}]},{"featureType": "water",  "elementType": "labels.text.fill",  "stylers": [{"color": "#9e9e9e"}]}]';

