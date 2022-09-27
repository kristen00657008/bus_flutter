import 'package:bus/bean/bus/route_bean/route_bean.dart';
import 'package:bus/bean/weather/weather_bean.dart';
import 'package:bus/bloc/system/application_bloc.dart';
import 'package:bus/bloc/system/default_page_bloc.dart';
import 'package:bus/http/weather/weather_repository.dart';
import 'package:bus/resource/city_data.dart';
import 'package:bus/resource/colors.dart';
import 'package:bus/route/page_name.dart';
import 'package:bus/route/route_mixin.dart';
import 'package:flutter/material.dart';
import 'package:bus/bloc/core/home_page_bloc.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late HomePageBloc bloc;
  late DefaultPageBloc defaultPageBloc;

  final double appBarBottomHeight = 35;
  final _tabs = const [
    "Tab 1",
    "Tab 2",
    "Tab 3",
  ];

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<HomePageBloc>(context);
    defaultPageBloc = BlocProvider.of<DefaultPageBloc>(context);
    FocusManager.instance.primaryFocus?.unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    bloc.init(this);
    bloc.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: StreamBuilder<bool>(
          stream: bloc.isSearchingStream,
          initialData: false,
          builder: (context, snapshot) {
            var isSearching = snapshot.requireData;
            return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    _buildAppBar(innerBoxIsScrolled, isSearching),
                  ];
                },
                body: isSearching
                    ? _buildSearchView()
                    : TabBarView(
                  children: _tabs.map((String tabName) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverFixedExtentList(
                          itemExtent: 48.0,
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) =>
                                ListTile(
                                    title: Text(
                                      '$tabName Item $index',
                                      style: TextStyle(color: Colors.white),
                                    )),
                            childCount: 30,
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ));
          }),
    );
  }

  Widget _buildAppBar(bool innerBoxIsScrolled, bool isSearching) {
    return SliverAppBar(
        titleSpacing: 0,
        title: _buildAppBarTitle(isSearching),
        floating: false,
        snap: false,
        pinned: true,
        expandedHeight: bloc.expandHeight,
        forceElevated: innerBoxIsScrolled,
        automaticallyImplyLeading: false,
        actions: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: isSearching ? 70 : 0,
            child: isSearching
                ? TextButton(
              child: Text(
                "取消",
                style: TextStyle(color: Colors.white, fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
              onPressed: () {
                bloc.changeToHomePage();
                bloc.setIsSearching(false);
                defaultPageBloc.setIsShowBottomNavigation(true);
                bloc.searchTextClear();
              },
            )
                : Container(),
          ),
        ],
        flexibleSpace: _buildAppBarFlexibleSpace(isSearching),
        bottom: (isSearching || bloc.controller.isAnimating)
            ? null
            : _buildAppBarBottom(isSearching));
  }

  Widget _buildAppBarTitle(bool isSearching) {
    return Container(
      padding: isSearching
          ? EdgeInsets.only(left: 10, right: 0)
          : EdgeInsets.only(left: 0, right: 10),
      height: kToolbarHeight - 15,
      child: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            width: isSearching ? 0 : 70,
            child: IconButton(
              icon: Icon(
                Icons.menu,
                size: 35,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                bloc.setIsSearching(true);
                bloc.changeToSearching();
                defaultPageBloc.setIsShowBottomNavigation(false);
              },
              child: TextField(
                controller: bloc.searchController,
                textAlign: isSearching ? TextAlign.start : TextAlign.center,
                style: TextStyle(color: whiteColor, fontSize: 18),
                enabled: isSearching ? true : false,
                autofocus: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: searchBarColor,
                  hintText: isSearching ? "搜尋公車路線/起迄方向名" : "搜尋公車路線",
                  hintStyle: TextStyle(color: whiteColor, fontSize: 18),
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: StreamBuilder<String>(
                      stream: bloc.searchTextStream,
                      builder: (context, snapshot) {
                        return Offstage(
                          offstage: snapshot.hasData
                              ? snapshot.requireData.isEmpty
                              : true,
                          child: InkWell(
                            onTap: () {
                              bloc.searchTextClear();
                            },
                            splashFactory: NoSplash.splashFactory,
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white70,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 15,
                              ),
                            ), //............
                          ),
                        );
                      }),
                  suffixIconConstraints: BoxConstraints(maxHeight: 20),
                  contentPadding: EdgeInsets.only(bottom: 0, left: 5),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (text) {
                  bloc.searchTextChange(text);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarFlexibleSpace(bool isSearching) {
    return StreamBuilder<WeatherBean>(
        stream: bloc.weatherBeanStream,
        builder: (context, snapshot) {
          var weatherData = snapshot.data;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [appBarColor1, appBarColor2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 1.0],
              ),
            ),
            child: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Offstage(
                offstage: isSearching || bloc.controller.isAnimating,
                child: Container(
                  padding: EdgeInsets.only(
                      top: kToolbarHeight * 2, bottom: appBarBottomHeight),
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      _buildWeatherLeft(weatherData),
                      _buildWeatherRight(weatherData),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildWeatherLeft(WeatherBean? weatherData) {
    final String wX = weatherData != null
        ? weatherData.weatherElementList[6].time[0].elementValue.last.value
        : "";
    var weatherIcon = "";
    switch (wX) {
      case "02": // 晴時多雲
        weatherIcon = "assets/sun.png";
        break;
      case "03": // 多雲時晴
        weatherIcon = "assets/partly_clear.png";
        break;
      case "04": // 多雲
        weatherIcon = "assets/cloudy.png";
        break;
      case "05": // 多雲時陰
        weatherIcon = "assets/over_cloudy.png";
        break;
      case "06": // 陰時多雲
        weatherIcon = "assets/partly_clear.png";
        break;
      case "22": // 多雲午後短暫陣雨
        weatherIcon = "assets/raining.png";
        break;
      default:
        weatherIcon = "assets/partly_clear.png";
        break;
    }
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.48,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _buildTemperature(weatherData),
          ),
          Container(
            width: 1,
            margin: EdgeInsets.symmetric(
              vertical: 10,
            ),
            color: Colors.grey,
          ),
          Expanded(
              flex: 5,
              child: FractionallySizedBox(
                  widthFactor: 0.7, child: Image.asset(weatherIcon))),
        ],
      ),
    );
  }

  Widget _buildTemperature(WeatherBean? weatherData) {
    final T = weatherData != null
        ? weatherData.weatherElementList[1].time[0].elementValue.first.value
        : "——";
    final minT = weatherData != null
        ? weatherData.weatherElementList[8].time[0].elementValue.first.value
        : "——";
    final maxT = weatherData != null
        ? weatherData.weatherElementList[12].time[0].elementValue.first.value
        : "——";
    return Column(
      children: [
        Text(
          T,
          style: TextStyle(
            fontSize: 60,
            color: whiteColor,
          ),
        ),
        Expanded(
          child: Text(
            minT + " / " + maxT,
            style: TextStyle(
              fontSize: 15,
              color: whiteColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherRight(WeatherBean? weatherData) {
    final String wX = weatherData != null
        ? weatherData.weatherElementList[6].time[0].elementValue.first.value
        : "——";
    final String minCT = weatherData != null
        ? weatherData.weatherElementList[3].time[0].elementValue.last.value
        : "——";
    final String maxCT = weatherData != null
        ? weatherData.weatherElementList[7].time[0].elementValue.last.value
        : "——";
    final cT = weatherData != null
        ? minCT == maxCT
        ? minCT
        : minCT + "至" + maxCT
        : "——";
    final poP12h = weatherData != null
        ? "降雨 " +
        weatherData.weatherElementList[0].time[0].elementValue.last.value +
        "%"
        : "降雨 ——%";
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.52,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                wX,
                style: TextStyle(
                  fontSize: 14,
                  color: whiteColor,
                ),
              ),
              Text(
                cT,
                style: TextStyle(
                  fontSize: 12,
                  color: whiteColor,
                ),
              ),
              Text(
                poP12h,
                style: TextStyle(
                  fontSize: 12,
                  color: whiteColor,
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(right: 10, top: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: buttonWhiteColor,
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(width: 60, height: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 15,
                      ),
                      Expanded(
                        child: PopupMenuButton(
                          itemBuilder: (context) =>
                              cities
                                  .map((city) =>
                                  PopupMenuItem<String>(
                                    value: city.chineseName,
                                    child: Text(
                                      city.chineseName,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: buttonDisableColor,
                                      ),
                                    ),
                                  ))
                                  .toList(),
                          child: Text(
                            ApplicationBloc
                                .getInstance()
                                .currentCity,
                            style: TextStyle(
                              fontSize: 12,
                              color: buttonDisableColor,
                            ),
                          ),
                          onSelected: (String city) {
                            bloc.setCity(city);
                            bloc.getWeather();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBarBottom(bool isSearching) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight - 20),
      child: Container(
        height: appBarBottomHeight,
        padding: EdgeInsets.only(left: 150),
        child: isSearching
            ? Container()
            : TabBar(
          indicatorWeight: 3,
          indicatorColor: Colors.white,
          tabs: _tabs
              .map((String tabName) =>
              Tab(
                text: tabName,
              ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildSearchView() {
    return StreamBuilder<bool>(
      stream: bloc.showHistoryStream,
      initialData: true,
      builder: (context, snapshot) {
          var showHistory = snapshot.requireData;
          return showHistory
              ? _buildHistory()
              :_buildSearchList();
      },
    );
  }

  Widget _buildSearchList() {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: StreamBuilder<List<RouteBean>>(
          stream: bloc.routeBeanStream,
          initialData: const [],
          builder: (context, snapshot) {
            var routes = snapshot.requireData;
            return ListView.separated(
              // controller: bloc.searchListController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.zero,
              itemCount: routes.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  height: 1,
                  color: Colors.grey,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    routes[index].subRoutes.first.subRouteName.tw +
                        routes[index].subRoutes.first.headSign,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    routes[index].departureStopNameZh +
                        " - " +
                        routes[index].destinationStopNameZh,
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                  visualDensity: VisualDensity(vertical: -3.5),
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    Future.delayed(Duration(milliseconds: 200), () {
                      bloc.pushPage(PageName.BusRoutePage, context,
                          transitionEnum: TransitionEnum.rightLeft);
                    });
                  },
                );
              },
            );
          }),
    );
  }

  Widget _buildHistory() {
    return ListView.separated(
      itemCount: 0,
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 1,
          color: Colors.grey,
        );
      },
      itemBuilder: (context, index) {
        return Container();
      },

    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
