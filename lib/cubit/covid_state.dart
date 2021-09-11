part of 'covid_cubit.dart';

abstract class CovidState extends Equatable {}

class CovidDayInitial extends CovidState {
  @override
  List<Object> get props => [];
}

class CovidLoading extends CovidState {
  @override
  List<Object> get props => [];
}

class CovidDayLoaded extends CovidState {
  final CovidDay covidDay;

  CovidDayLoaded({required this.covidDay});

  @override
  List<Object> get props => [CovidDay];
}

class CovidProvinceLoaded extends CovidState {
  final List<CovidProvince> covidProvince;

  CovidProvinceLoaded({required this.covidProvince});

  @override
  List<Object> get props => [covidProvince];
}

class CovidError extends CovidState {
  final error;
  CovidError(this.error);

  @override
  List<Object> get props => [error];
}
