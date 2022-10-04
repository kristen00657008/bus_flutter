import 'package:bus/bean/bus/stop_of_route_bean/stop_of_route_bean.dart';
import 'package:bus/bloc/bus_route_page_bloc.dart';
import 'package:bus/resource/colors.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:flutter/material.dart';

class BusRoutePage extends StatefulWidget {
  const BusRoutePage({Key? key}) : super(key: key);

  @override
  State<BusRoutePage> createState() => BusRoutePageState();
}
class BusRoutePageState extends State<BusRoutePage>
    with TickerProviderStateMixin {
  late BusRoutePageBloc bloc;
  @override
  void initState() {

    super.initState();
    bloc = BlocProvider.of<BusRoutePageBloc>(context);
    bloc.getStopOfRoute();
    bloc.initIndicator(this);
  }

  @override
  void dispose() {
    bloc.indicatorController.dispose();
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<StopOfRouteBean>>(
        stream: bloc.stopOfRouteStream,
        builder: (context, AsyncSnapshot<List<StopOfRouteBean>> snapshot) {
          if (!snapshot.hasData || snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          List<StopOfRouteBean> stopOfRoutes = snapshot.data ?? [];
          bloc.tabController =
              TabController(vsync: this, length: stopOfRoutes.length);
          return DefaultTabController(
            length: stopOfRoutes.length,
            child: Scaffold(
              appBar: _buildAppBar(stopOfRoutes),
              backgroundColor: defaultBackgroundColor,
              body: TabBarView(
                controller: bloc.tabController,
                children: stopOfRoutes.map((StopOfRouteBean stopOfRoute) {
                  return ListView.separated(
                    itemCount: stopOfRoute.stops.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 0.2,
                        color: Colors.grey,
                      );
                    },
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
      title: Text(stopOfRoutes.isNotEmpty ? stopOfRoutes.first.routeName.tw : ""),
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
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Column(
          children: [
            TabBar(
              controller: bloc.tabController,
              indicatorColor: buttonWhiteColor,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 3.0, color: Colors.yellow),
                insets: EdgeInsets.symmetric(vertical: 5),
              ),
              indicatorSize: TabBarIndicatorSize.label ,
              labelStyle: TextStyle(fontSize: 15),
              tabs: stopOfRoutes.map((stopOfRoute) {
                String label = stopOfRoutes.indexOf(stopOfRoute) == 0
                    ? bloc.busRoute.destinationStopNameZh
                    : bloc.busRoute.departureStopNameZh;
                return Tab(
                  text: "往 $label",
                );
              }).toList(),
            ),
            StreamBuilder<Animation>(
              stream: bloc.indicatorAnimationStream,
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  return AnimatedBuilder(
                      animation: snapshot.requireData,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: snapshot.requireData.value ,
                          backgroundColor: secondBackgroundColor,
                          valueColor: AlwaysStoppedAnimation<Color>(appBarColor1),
                        );
                      }
                  );
                }
                return Container(color: Colors.purple);
              }
            ),
          ],
        ),
      ),
    );
  }
}
