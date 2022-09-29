import 'package:bus/bloc/system/application_bloc.dart';
import 'package:bus/bloc/system/default_page_bloc.dart';
import 'package:bus/model/system/bottom_navigation_data.dart';
import 'package:bus/resource/colors.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:bus/route/page_name.dart';
import 'package:bus/route/route_data.dart';
import 'package:bus/ui/widget/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  late DefaultPageBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<DefaultPageBloc>(context);
    ApplicationBloc.getInstance().getNeededApi();
    ApplicationBloc.getInstance().init();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RouteData>(
        stream: ApplicationBloc.getInstance().subPageStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          var routeData = snapshot.requireData;

          return Scaffold(
            backgroundColor: defaultBackgroundColor,
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: StreamBuilder<bool>(
                stream: bloc.isShowBottomStream,
                initialData: true,
                builder: (context, snapshot) {
                  if (snapshot.requireData) {
                    return _buildBottomNavigationBar(routeData);
                  }
                  return SizedBox();
                }),
            drawer: Drawer(),
            drawerEnableOpenDragGesture: false,
            body: Container(
              child: _contentPage(routeData),
            ),
          );
        });
  }

  Widget _contentPage(RouteData routeData) {
    return Builder(builder: (context) {
      return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SizedBox.expand(
            child: bloc.getPage(routeData),
          ));
    });
  }

  Widget _buildBottomNavigationBar(RouteData routeData) {
    return BottomNavigationWidget(
        currentRouteName: routeData.routeName,
        bottomNavigationList: bloc.bottomNavigationList,
        onTap: (BottomNavigationData data) {
          var url = '';
          switch (data.type) {
            case BottomNavigationEnum.homePage:
              url = PageName.HomePage;
              break;
            case BottomNavigationEnum.locationPage:
              url = PageName.LocationPage;
              break;
            case BottomNavigationEnum.mrtPage:
              url = PageName.MRTPage;
              break;
            case BottomNavigationEnum.settingPage:
              url = PageName.SettingPage;
              break;
          }
          if (url.isNotEmpty) {
            bloc.setSubPage(url);
          }
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
