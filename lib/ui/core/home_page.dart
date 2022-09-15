import 'package:bus/resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:bus/bloc/core/home_page_bloc.dart';
import 'package:bus/route/base_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late HomePageBloc bloc;
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
    bloc.init(this);
    bloc.controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _buildAppBar(innerBoxIsScrolled),
            ];
          },
          body: TabBarView(
            children: _tabs.map((String tabName) {
              return CustomScrollView(
                slivers: <Widget>[
                  // SliverOverlapInjector(
                  //     handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                  SliverFixedExtentList(
                    itemExtent: 48.0,
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) => ListTile(
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
          )),
    );
  }

  Widget _buildAppBar(bool innerBoxIsScrolled) {
    return StreamBuilder<bool>(
        stream: bloc.isSearchingStream,
        builder: (context, snapshot) {
          var isSearching = false;
          if (snapshot.hasData) {
            isSearching = snapshot.requireData;
          }
          return SliverAppBar(
              titleSpacing: 0,
              title: _buildAppBarTitle(isSearching),
              floating: false,
              snap: false,
              pinned: true,
              expandedHeight: bloc.expandHeight,
              forceElevated: innerBoxIsScrolled,
              backgroundColor: appBarColor,
              actions: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
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
                          },
                        )
                      : Container(),
                ),
              ],
              flexibleSpace: _buildAppBarFlexibleSpace(isSearching),
              bottom: (isSearching || bloc.controller.isAnimating) ? null : _buildAppBarBottom(isSearching));
        });
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
            duration: Duration(milliseconds: 200),
            width: (isSearching || bloc.controller.isAnimating) ? 0 : 70,
            child: (isSearching || bloc.controller.isAnimating)
                ? Container()
                : IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 35,
                    ),
                    onPressed: () {
                      bloc.getWeather();
                    },
                  ),
          ),
          Expanded(
            child: TextField(
              onTap: () {
                bloc.setIsSearching(true);
                bloc.changeToSearching();
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: searchBarColor,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarFlexibleSpace(bool isSearching) {
    return FlexibleSpaceBar(
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
              _buildWeatherLeft(),
              _buildWeatherRight(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherLeft() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: _buildTemperature(),
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
            child: Icon(
              Icons.sunny,
              size: 80,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperature() {
    return Column(
      children: const [
        Text(
          "32",
          style: TextStyle(
            fontSize: 60,
            color: whiteColor,
          ),
        ),
        Text(
          "30 / 33",
          style: TextStyle(
            fontSize: 15,
            color: whiteColor,
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherRight() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text(
                "晴時多雲",
                style: TextStyle(
                  fontSize: 18,
                  color: whiteColor,
                ),
              ),
              Text(
                "悶熱",
                style: TextStyle(
                  fontSize: 12,
                  color: whiteColor,
                ),
              ),
              Text(
                "降雨 10%",
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
              child: ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 80, height: 20),
                child: ElevatedButton(
                  child: Row(
                    children: const [
                      Icon(
                        Icons.location_on,
                        size: 15,
                      ),
                      Expanded(
                        child: Text('台中市'),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: buttonWhiteColor,
                    textStyle: TextStyle(
                      fontSize: 10,
                      color: buttonDefaultColor,
                    ),
                  ),
                  onPressed: () {},
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
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Container(
        height: appBarBottomHeight,
        padding: EdgeInsets.only(left: 150),
        child: isSearching
            ? Container()
            : TabBar(
                indicatorWeight: 3,
                indicatorColor: Colors.white,
                tabs: _tabs
                    .map((String tabName) => Tab(
                          text: tabName,
                        ))
                    .toList(),
              ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
}
