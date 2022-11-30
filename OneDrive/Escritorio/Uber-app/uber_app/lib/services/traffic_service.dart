import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uber_app/models/models.dart';
import 'package:uber_app/services/services.dart';

class TrafficService {
  final Dio _dioTraffic;
  final Dio _dioPlaces;

  final String _baseTrafficUrl = 'https://api.mapbox.com/directions/v5/mapbox';
  final String _basePlacesUrl =
      'https://api.mapbox.com/geocoding/v5/mapbox.places';

  TrafficService()
      : _dioTraffic = Dio()..interceptors.add(TrafficInterceptor()),
        _dioPlaces = Dio()..interceptors.add(PlacesInterceptor());

  Future<TrafficResponse> getcoorsStartToEnd(LatLng start, LatLng end) async {
    final coorsString =
        '${start.longitude}%2C${start.latitude}%3B${end.longitude}%2C${end.latitude}';
    final url = '$_baseTrafficUrl/driving/$coorsString';
    final resp = await _dioTraffic.get(url);
    final data = TrafficResponse.fromJson(resp.data);
    return data;
  }

  Future<List<Feature>> getResultsByQuery(
      LatLng proximity, String query) async {
    if (query.isEmpty) return [];
    final url = '$_basePlacesUrl/$query.json';

    final resp = await _dioPlaces.get(url, queryParameters: {
      'limit': 5,
      'proximity': '${proximity.longitude},${proximity.latitude}'
    });

    final placesResponse = PlacesResponse.fromJson(resp.data);

    return placesResponse.features;
  }

  Future<Feature> getInformationByCoors(LatLng coors) async {
    final url = '$_basePlacesUrl/${coors.longitude},${coors.latitude}.json';
    final resp = await _dioPlaces.get(url, queryParameters: {'limit': 1});

    final placesResponse = PlacesResponse.fromJson(resp.data);
    return placesResponse.features.first;
  }
}
