import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_covid_app/models/covidDay.dart';
import 'package:flutter_covid_app/models/covidProvince.dart';
import 'package:flutter_covid_app/repository/covidDay.dart';

part 'covid_state.dart';

class CovidCubit extends Cubit<CovidState> {
  final CovidRepository covidRepository;

  CovidCubit({required this.covidRepository}) : super(CovidDayInitial());

  void getCovidToday() async {
    try {
      emit(CovidLoading());
      final _covidToday = await covidRepository.getCovidToday();
      emit(CovidDayLoaded(covidDay: _covidToday));
    } catch (e) {
      print(e.toString());
    }
  }

  void getCovidProvince() async {
    try {
      emit(CovidLoading());
      final _covidProvince = await covidRepository.getCovidProvince();
      emit(CovidProvinceLoaded(covidProvince: _covidProvince));
    } catch (e) {
      print(e.toString());
    }
  }
}
