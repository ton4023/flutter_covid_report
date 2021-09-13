import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_covid_app/cubit/covid_cubit.dart';
import 'package:flutter_covid_app/models/covidDay.dart';
import 'package:flutter_covid_app/models/covidProvince.dart';
import 'package:flutter_covid_app/repository/covidDay.dart';
import 'package:flutter_covid_app/widgets/widget.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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
            ClipPath(
              clipper: WaveClipperOne(),
              child: Container(
                alignment: Alignment.center,
                height: 120,
                color: Colors.lightBlue[50],
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'รายงานสถานการณ์ COVID-19',
                      style:
                          TextStyle(
                            fontSize: 22, 
                          fontWeight: FontWeight.w600,
                          color: Colors.blue[900]),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: showDaily(),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.all(8),
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
        return Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        );
      }),
    );
  }

  detailDaily(double size, CovidDay covidDay) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: size / 2 * .9,
              child: CustomCard(
                name: "จำนวนผู้ติดเชื้อรายใหม่",
                quantity: covidDay.newCase,
                color: Colors.amber[600],
              ),
            ),
            Container(
              width: size / 2 * .9,
              child: CustomCard(
                name: "จำนวนผู้เสียชีวิตรายใหม่",
                quantity: covidDay.newDeath,
                color: Colors.red[600],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: size / 3 * .9,
              child: CustomCard(
                name: "ผู้ติดเชื้อสะสม",
                quantity: covidDay.totalCase,
                color: Colors.green[600],
              ),
            ),
            Container(
              width: size / 3 * .9,
              child: CustomCard(
                name: "รักษาหาย",
                quantity: covidDay.totalRecovered,
                color: Colors.blue[600],
              ),
            ),
            Container(
              width: size / 3 * .9,
              child: CustomCard(
                name: "ผู้เสียชีวิตสะสม",
                quantity: covidDay.totalDeath,
                color: Colors.purple[600],
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: Text('อัพเดตล่าสุด ' + covidDay.updateDate.toString()),
        )
      ],
    );
  }

  showProvince() {
    return RepositoryProvider(
      create: (context) => CovidCubit(
        covidRepository: _covidRepository,
      )..getCovidProvince(),
      child: BlocBuilder<CovidCubit, CovidState>(builder: (context, state) {
        if (state is CovidLoading) {
          Container(
            child: CircularProgressIndicator(),
          );
        } else if (state is CovidProvinceLoaded) {
          final covidProvince = state.covidProvince;
          final size = MediaQuery.of(context).size.width;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'แยกตามรายจังหวัด',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    ),
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
        return Container();
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
                name: "จำนวนผู้ติดเชื้อรายใหม่",
                quantity: covidProvince[_provinceIndex].newCase,
                color: Colors.amber[600],
              ),
            ),
            Container(
              width: size / 2 * 0.9,
              child: CustomCard(
                name: "จำนวนผู้เสียชีวิตรายใหม่",
                quantity: covidProvince[_provinceIndex].newDeath,
                color: Colors.red[600],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: size / 3 * 0.9,
              child: CustomCard(
                  name: "ผู้ติดเชื้อสะสม",
                  quantity: covidProvince[_provinceIndex].totalCase,
                  color: Colors.green[600]),
            ),
            Container(
              width: size / 3 * 0.9,
              child: CustomCard(
                name: "รักษาหาย",
                quantity: '-',
                color: Colors.blue[600],
              ),
            ),
            Container(
              width: size / 3 * 0.9,
              child: CustomCard(
                name: "ผู้เสียชีวิตสะสม",
                quantity: covidProvince[_provinceIndex].totalDeath,
                color: Colors.purple[600],
              ),
            )
          ],
        ),
        Container(
          alignment: Alignment.bottomRight,
          child: Text('อัพเดตล่าสุด ' +
              covidProvince[_provinceIndex].updateDate.toString()),
        )
      ],
    );
  }
}
