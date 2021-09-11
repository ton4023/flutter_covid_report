import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_covid_app/cubit/covid_cubit.dart';
import 'package:flutter_covid_app/repository/covidDay.dart';
import 'package:flutter_covid_app/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final _covidDayRepository = CovidRepository();
    final sizeWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => CovidCubit(
        covidRepository: _covidDayRepository,
      )..getCovidToday(),
      child: BlocBuilder<CovidCubit, CovidState>(builder: (context, state) {
        if (state is CovidDayLoaded) {
          return CustomScrollView(slivers: [
            CustomSliverAppbar(),
            show_daliy(sizeWidth, state),
          ]);
        }
        return Container();
      }),
    );
  }

  // ignore: non_constant_identifier_names
  show_daliy(double sizeWidth, CovidDayLoaded state) {
    return SliverList(
        delegate: SliverChildListDelegate([
      Container(
        padding: EdgeInsets.all(8),
        child: Text(
          'รายงานยอดผุ้ติดเชื้อ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: sizeWidth / 2 * 0.9,
            child:
                CustomCard(name: 'New Case', quantity: state.covidDay.newCase),
          ),
          Container(
            width: sizeWidth / 2 * 0.9,
            child: CustomCard(
                name: 'New Death', quantity: state.covidDay.newDeath),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: sizeWidth / 3 * 0.9,
            child: CustomCard(
                name: 'Total Case', quantity: state.covidDay.totalCase),
          ),
          Container(
            width: sizeWidth / 3 * 0.9,
            child: CustomCard(
                name: 'Total Recovered',
                quantity: state.covidDay.totalRecovered),
          ),
          Container(
            width: sizeWidth / 3 * 0.9,
            child: CustomCard(
                name: 'Total Death', quantity: state.covidDay.totalDeath),
          ),
        ],
      ),
      Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.bottomRight,
          child: Text('อัพเดตล่าสุด ' + state.covidDay.updateDate.toString()))
    ]));
  }
}
