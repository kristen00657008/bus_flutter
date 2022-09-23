import 'package:flutter/material.dart';
import 'package:bus/bloc/system/application_bloc.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:bus/route/route_data.dart';
import 'package:bus/route/route_mixin.dart';

class PageBloc implements BaseBloc {
  @override
  late BlocOption option;

  PageBloc(BlocOption blocOption) {
    option = blocOption;
  }

  Widget getPage(RouteData routeData) {
    return ApplicationBloc.getInstance().getPage(
        routeData.routeName, blocQuery: routeData.blocQuery);
  }

  void setSubPage(String route, {
    Map<String, dynamic> blocquery = const {},
    bool addHistory = true
  }) {
    ApplicationBloc.getInstance().addSubPageRoute(RouteData(
        route,
        blocQuery: blocquery,
        addHistory: addHistory
    ));
  }

  void popSubPage() {
    ApplicationBloc.getInstance().popSubPage();
  }

  void pushPage(String route,
    BuildContext context, {
    bool replaceCurrent = false,
    Map<String, dynamic> blocQuery = const {},
    TransitionEnum transitionEnum = TransitionEnum.normal,
  }) {
    ApplicationBloc.getInstance().pushPage(
        route,
        context,
        blocQuery: blocQuery,
        transitionEnum: transitionEnum
    );
  }


  @override
  void dispose() {

  }


}