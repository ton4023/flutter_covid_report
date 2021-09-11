import 'dart:convert';
import 'package:flutter_covid_app/models/covidProvince.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_covid_app/models/covidDay.dart';

class CovidRepository {
  //https://covid19.ddc.moph.go.th/api/Cases/today-cases-all

  Future<CovidDay> getCovidToday() async {
    final uri =
        Uri.https('covid19.ddc.moph.go.th', 'api/Cases/today-cases-all');

    final response = await http.get(uri);

    return CovidDay.fromJson(jsonDecode(response.body)[0]);
  }

  //https://covid19.ddc.moph.go.th/api/Cases/today-cases-by-provinces

  Future<List<CovidProvince>> getCovidProvince() async {
    final uri = Uri.https(
        'covid19.ddc.moph.go.th', 'api/Cases/today-cases-by-provinces');

    final response = await http.get(uri);

    List<CovidProvince> covidProvince = (jsonDecode(response.body) as List)
        .map((json) => CovidProvince.fromJson(json))
        .toList();

    return covidProvince;
  }
}
