import 'package:bus/bean/bus/estimatedTimeOfArrival_bean/estimatedTimeOfArrival_bean.dart';
import 'package:bus/bean/bus/stop_of_route_bean/stop_of_route_bean.dart';
import 'package:bus/bloc/bus_route_page_bloc.dart';
import 'package:bus/notificationservice.dart';
import 'package:bus/resource/colors.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:flutter/cupertino.dart';
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
    bloc.getEstimatedTimeOfArrival();
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
        builder: (context, AsyncSnapshot<List<StopOfRouteBean>> stopSnapshot) {
          if (!stopSnapshot.hasData ||
              stopSnapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          List<StopOfRouteBean> stopOfRoutes = stopSnapshot.data ?? [];
          bloc.tabController =
              TabController(vsync: this, length: stopOfRoutes.length);
          return DefaultTabController(
            length: stopOfRoutes.length,
            child: Scaffold(
              backgroundColor: defaultBackgroundColor,
              body: NestedScrollView(
                controller: bloc.scrollController,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    _buildAppBar(stopOfRoutes, innerBoxIsScrolled),
                  ];
                },
                body: StreamBuilder<List<EstimatedTimeOfArrivalBean>>(
                    stream: bloc.estimatedTimeStream,
                    builder: (context, estimateTimeSnapshot) {
                      return TabBarView(
                        controller: bloc.tabController,
                        children:
                            stopOfRoutes.map((StopOfRouteBean stopOfRoute) {
                          return CustomScrollView(
                            slivers: <Widget>[
                              SliverFixedExtentList(
                                itemExtent: 56.0,
                                delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, int index) => Column(
                                    children: [
                                      Expanded(
                                        child: ListTile(
                                          leading: _buildEstimatedWidget(
                                              estimateTimeSnapshot,
                                              stopOfRoute,
                                              index),
                                          contentPadding:
                                              EdgeInsets.only(left: 5),
                                          title: Text(
                                            stopOfRoute
                                                .stops[index].stopName.tw,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onTap: () {
                                            _showActionSheet(
                                                context, stopOfRoute, index);
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: 0.2,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                  childCount: stopOfRoute.stops.length,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    }),
              ),
            ),
          );
        });
  }

  void _showActionSheet(BuildContext context, StopOfRouteBean stopOfRoute, index) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
              int currentEstimateTime = bloc
                  .getEstimatedInfo(
                      stopOfRoute.stops[index], bloc.tabController.index)
                  .time - 300;
              if(currentEstimateTime > 0 ) {
                print("$currentEstimateTime 秒後發出通知");
                NotificationService().showNotification(
                  stopOfRoute.stops[index].stopSequence,
                  "公車即將到站通知",
                  "${bloc.busRoute.routeName.tw}即將到達:${stopOfRoute.stops[index].stopName.tw}",
                  currentEstimateTime,
                );
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("已預約到站通知"),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("無法新增5分鐘內到達公車提醒"),
                ));
              }

            },
            child: const Text("新增到站提醒"),
          ),
        ],
        cancelButton: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              color: Colors.teal),
          child: CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(
      List<StopOfRouteBean> stopOfRoutes, bool innerBoxIsScrolled) {
    return SliverAppBar(
        titleSpacing: 0,
        floating: false,
        snap: false,
        pinned: true,
        expandedHeight: 150,
        forceElevated: innerBoxIsScrolled,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
            ),
            Text(
              stopOfRoutes.isNotEmpty ? stopOfRoutes.first.routeName.tw : "",
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.map_outlined),
            ),
          ],
        ),
        centerTitle: true,
        flexibleSpace: Container(
          child: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: Container(
              padding: EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  bloc.busRoute.destinationStopNameZh +
                      " - " +
                      bloc.busRoute.departureStopNameZh,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: const [appBarColor1, appBarColor2],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 1.0],
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: Column(
            children: [
              TabBar(
                controller: bloc.tabController,
                indicatorColor: buttonWhiteColor,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 2.5, color: Colors.yellow),
                  insets: EdgeInsets.symmetric(vertical: 2),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: TextStyle(fontSize: 15),
                tabs: stopOfRoutes.map((stopOfRoute) {
                  String label = stopOfRoutes.indexOf(stopOfRoute) == 0
                      ? bloc.busRoute.destinationStopNameZh
                      : bloc.busRoute.departureStopNameZh;
                  return Tab(
                    text: "往 $label",
                    height: 30,
                  );
                }).toList(),
              ),
              StreamBuilder<Animation>(
                  stream: bloc.indicatorAnimationStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return AnimatedBuilder(
                          animation: snapshot.requireData,
                          builder: (context, child) {
                            return LinearProgressIndicator(
                              value: snapshot.requireData.value,
                              backgroundColor: secondBackgroundColor,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(appBarColor1),
                            );
                          });
                    }
                    return Container(color: Colors.purple);
                  }),
            ],
          ),
        ));
  }

  Widget _buildEstimatedWidget(estimateTimeSnapshot, stopOfRoute, int index) {
    if (!estimateTimeSnapshot.hasData || stopOfRoute.stops.isEmpty) {
      return Container(
        width: 70,
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.teal, width: 2),
            borderRadius: BorderRadius.circular(18)),
      );
    }
    EstimatedInfo estimatedInfo = bloc.getEstimatedInfo(
        stopOfRoute.stops[index], bloc.tabController.index);
    switch (estimatedInfo.estimateState) {
      case EstimateState.none:
        return _buildNoneState();
      case EstimateState.estimateTime:
      case EstimateState.nextTime:
        return _buildTimeState(estimatedInfo);
      case EstimateState.soon:
        return _buildSoonState();
      case EstimateState.arrive:
        return _buildArrivalState();
      default:
        _buildSoonState();
    }
    return Container(
      width: 70,
    );
  }

  Widget _buildTimeState(EstimatedInfo estimatedInfo) {
    return Container(
      width: 70,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 0.5),
          borderRadius: BorderRadius.circular(18)),
      child: estimatedInfo.estimateState == EstimateState.estimateTime
          ? Center(
              child: RichText(
                text: TextSpan(
                  text: estimatedInfo.timeString,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w300),
                  children: const <TextSpan>[
                    TextSpan(
                        text: ' 分',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            )
          : Center(
              child: Text(
                estimatedInfo.timeString,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
    );
  }

  Widget _buildArrivalState() {
    return Container(
      width: 70,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(18)),
      child: Center(
        child: Text(
          "進站中",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _buildSoonState() {
    return Container(
      width: 70,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.teal, width: 2),
          borderRadius: BorderRadius.circular(18)),
      child: Center(
        child: Text(
          "將進站",
          style: TextStyle(
            color: Colors.teal,
          ),
        ),
      ),
    );
  }

  Widget _buildNoneState() {
    return Container(
      width: 70,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 2),
          borderRadius: BorderRadius.circular(18)),
      child: Center(
        child: Text(
          "未發車",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
