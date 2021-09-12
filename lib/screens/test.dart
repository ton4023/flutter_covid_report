import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_covid_app/cubit/covid_cubit.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_covid_app/cubit/covid_cubit.dart';
import 'package:flutter_covid_app/repository/covidDay.dart';
import 'package:flutter_covid_app/widgets/custom_dropdown.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final _covidRepository = CovidRepository();
  var _province;
  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  // getData() async {

  //   final res = await _covidRepository.getCovidProvince();
  //   print(res[0].newCase);

  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CovidCubit(covidRepository: _covidRepository)..getCovidProvince(),
      child: BlocBuilder<CovidCubit, CovidState>(builder: (context, state) {
        if (state is CovidProvinceLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  child: ProvinceDropdown(
                province: _province ?? state.covidProvince[0].province,
                provinces: state.covidProvince,
                onChanged: (value) {
                  setState(() {
                    _province = value;
                  });
                },
              )),
              Text('$_province')
            ],
          );
        }
        return Container();
      }),
    );
  }
}
