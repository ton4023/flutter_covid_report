import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_covid_app/cubit/covid_cubit.dart';
import 'package:flutter_covid_app/models/covidDay.dart';
import 'package:flutter_covid_app/models/covidProvince.dart';
import 'package:flutter_covid_app/repository/covidDay.dart';
import 'package:flutter_covid_app/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _covidRepository = CovidRepository();
  var _province;
  var _provinceIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
          CustomSliverAppbar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              child: showDaily(),
            ),
            Container(
              child: showProvince(),
            )
          ]))
        ],
      ),
    );
  }

  findIndex(arr) {
    var index;
    arr.forEach((e) => {
          if (e != '') {index = e}
        });
    return index;
  }

  showDaily() {
    return RepositoryProvider(
      create: (context) => CovidCubit(
        covidRepository: _covidRepository,
      )..getCovidToday(),
      child: BlocBuilder<CovidCubit, CovidState>(builder: (context, state) {
        if (state is CovidDayLoaded) {
          final covidDay = state.covidDay;
          final size = MediaQuery.of(context).size.width;
          return detailDaily(size, covidDay);
        }
        return Container(
          child: Text('no daily data'),
        );
      }),
    );
  }

  Column detailDaily(double size, CovidDay covidDay) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('ยอดผู้ติดเชื้อ'),
        cardDetail(size, covidDay),
        cardDetail2(size, covidDay)
      ],
    );
  }

  Row cardDetail(double size, CovidDay covidDay) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: size / 2 * .9,
          child: CustomCard(name: "newCase", quantity: covidDay.newCase),
        ),
        Container(
          width: size / 2 * .9,
          child: CustomCard(name: "newDeath", quantity: covidDay.newDeath),
        ),
      ],
    );
  }

  Row cardDetail2(double size, CovidDay covidDay) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: size / 3 * .9,
          child: CustomCard(name: "Total Case", quantity: covidDay.totalCase),
        ),
        Container(
          width: size / 3 * .9,
          child: CustomCard(
              name: "Total Recovered", quantity: covidDay.totalRecovered),
        ),
        Container(
          width: size / 3 * .9,
          child: CustomCard(name: "Total Death", quantity: covidDay.totalDeath),
        ),
      ],
    );
  }

  showProvince() {
    return RepositoryProvider(
      create: (context) => CovidCubit(
        covidRepository: _covidRepository,
      )..getCovidProvince(),
      child: BlocBuilder<CovidCubit, CovidState>(builder: (context, state) {
        if (state is CovidProvinceLoaded) {
          final covidProvince = state.covidProvince;
          final size = MediaQuery.of(context).size.width;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('แยกรายจังหวัด'),
                    ProvinceDropdown(
                      province:
                          _province ?? covidProvince[0].province.toString(),
                      provinces: covidProvince,
                      onChanged: (val) {
                        var arrIndex = covidProvince.map((e) =>
                            e.province == val ? covidProvince.indexOf(e) : '');

                        setState(() {
                          _province = val!;
                          _provinceIndex = findIndex(arrIndex);
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: detailProvince(size, covidProvince),
              )
            ],
          );
        }
        return Container(
          child: Text('no province data'),
        );
      }),
    );
  }

  detailProvince(double size, List<CovidProvince> covidProvince) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: size / 2 * 0.9,
              child: CustomCard(
                  name: "newCase",
                  quantity: covidProvince[_provinceIndex].newCase),
            ),
            Container(
              width: size / 2 * 0.9,
              child: CustomCard(
                  name: "newDeath",
                  quantity: covidProvince[_provinceIndex].newDeath),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: size / 3 * 0.9,
              child: CustomCard(
                  name: "Total Case",
                  quantity: covidProvince[_provinceIndex].totalCase),
            ),
            Container(
              width: size / 3 * 0.9,
              child: CustomCard(
                  name: "Total Recovered",
                  quantity: '-'),
            ),
            Container(
              width: size / 3 * 0.9,
              child: CustomCard(
                  name: "Total Death",
                  quantity: covidProvince[_provinceIndex].totalDeath),
            )
          ],
        ),
      ],
    );
  }
}
