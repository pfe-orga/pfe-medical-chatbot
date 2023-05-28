import 'package:flutter/cupertino.dart';

import '../data/models/GeoModel.dart';
import '../data/network/api/geolocation/geo_api.dart';
import '../data/sharedprefs/shared_resources_service.dart';

class GeoLocationController{
  final GeoApi geoApi ;
  final SharedResourcesService sharedResourcesService;
  GeoLocationController({required this.geoApi, required this.sharedResourcesService});


// --------------  Controller ---------------

  final  namesController = TextEditingController();
  final  placeController = TextEditingController();
  final  numeroController = TextEditingController();

// --------------  Methods ------------------

  Future<List<GeoModel>> getDoctorsList() async {
    return await geoApi.getDoctorsList();
  }
}