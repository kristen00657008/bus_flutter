import 'package:bus/bean/bus/stop_of_route_bean/stop_of_route_bean.dart';
import 'package:bus/bloc/bus_route_page_bloc.dart';
import 'package:bus/resource/colors.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:flutter/material.dart';

class BusRoutePage extends StatefulWidget {
  const BusRoutePage({Key? key}) : super(key: key);

  @override
  State<BusRoutePage> createState() => _BusRoutePageState();
}

class _BusRoutePageState extends State<BusRoutePage>
    with TickerProviderStateMixin {
  late BusRoutePageBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<BusRoutePageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<StopOfRouteBean>>(
        future: bloc.getStopOfRoute(),
        builder: (context, AsyncSnapshot<List<StopOfRouteBean>> snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          List<StopOfRouteBean> stopOfRoutes = snapshot.requireData;
          bloc.controller =
              TabController(vsync: this, length: stopOfRoutes.length);
          return DefaultTabController(
            length: stopOfRoutes.length,
            child: Scaffold(
              appBar: _buildAppBar(stopOfRoutes),
              backgroundColor: defaultBackgroundColor,
              body: TabBarView(
                controller: bloc.controller,
                children: stopOfRoutes.map((StopOfRouteBean stopOfRoute) {
                  return ListView.builder(
                    itemCount: stopOfRoute.stops.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          stopOfRoute.stops[index].stopName.tw,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {},
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          );
        });
  }

  PreferredSizeWidget _buildAppBar(List<StopOfRouteBean> stopOfRoutes) {
    return AppBar(
        title: Text(stopOfRoutes.first.routeName.tw),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [appBarColor1, appBarColor2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              bloc.getStopOfRoute();
            },
            icon: Icon(Icons.map_outlined),
          )
        ],
        bottom: TabBar(
          controller: bloc.controller,
          indicatorColor: buttonWhiteColor,
          indicatorWeight: 4,
          labelStyle: TextStyle(
            fontSize: 15
          ),
          tabs: stopOfRoutes.map((stopOfRoute) {
            String label = stopOfRoutes.indexOf(stopOfRoute) == 0 ? bloc
                .busRoute.destinationStopNameZh : bloc.busRoute
                .departureStopNameZh;
            return Tab(
              text: "往 $label",

            );
          }).toList(),
        )
    );
  }
}
