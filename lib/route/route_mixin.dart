import 'package:bus/bloc/core/home_page_bloc.dart';
import 'package:bus/bloc/core/location_page_bloc.dart';
import 'package:bus/bloc/core/mrt_page_bloc.dart';
import 'package:bus/bloc/core/setting_page_bloc.dart';
import 'package:bus/bloc/search_page_bloc.dart';
import 'package:bus/bloc/system/default_page_bloc.dart';
import 'package:bus/ui/core/default_page.dart';
import 'package:bus/ui/core/home_page.dart';
import 'package:bus/ui/core/location_page.dart';
import 'package:bus/ui/core/mrt_page.dart';
import 'package:bus/ui/core/setting_page.dart';
import 'package:bus/ui/search_page.dart';
import 'package:flutter/material.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:bus/route/page_name.dart';
import 'package:page_transition/page_transition.dart';

mixin RouteMixin {
  Future<T?> pushPage<T>(
    String routeName,
    BuildContext context, {
    Map<String, dynamic> blocQuery = const {},
    TransitionEnum transitionEnum = TransitionEnum.normal,
    bool pushAndReplace = false,
  }) async {
    var navigator = Navigator.of(context);
    var pageWidget = _getPage(routeName, blocQuery);

    var pageRoute = MaterialPageRoute<T>(
      settings: RouteSettings(name: routeName),
      builder: (context) => pageWidget,
    );

    var bottomToTopRoute = PageTransition(
        settings: RouteSettings(name: routeName),
        type: PageTransitionType.bottomToTop,
        child: pageWidget,
        duration: Duration(milliseconds: 350));

    var rightLeftRoute = PageTransition(
      settings: RouteSettings(name: routeName),
      type: PageTransitionType.rightToLeft,
      child: pageWidget,
    );

    switch (transitionEnum) {
      case TransitionEnum.normal:
        if (pushAndReplace) {
          navigator.pushReplacement(pageRoute);
        } else {
          navigator.push(pageRoute);
        }
        break;
      case TransitionEnum.bottomTop:
        navigator.push(bottomToTopRoute);
        break;
      case TransitionEnum.rightLeft:
        navigator.push(rightLeftRoute);
        break;
      default:
        throw "Transition fail";
    }
    return null;
  }

  Widget getPage(
    String route, {
    Map<String, dynamic> blocQuery = const {},
  }) {
    return _getPage(route, blocQuery);
  }

  Widget _getPage(String routeName, Map<String, dynamic> query) {
    switch (routeName) {
      case PageName.DefaultPage:
        return BlocProvider(
            bloc: DefaultPageBloc(BlocOption(query)), child: DefaultPage());
      case PageName.HomePage:
        return BlocProvider(
            bloc: HomePageBloc(BlocOption(query)), child: HomePage());
      case PageName.LocationPage:
        return BlocProvider(
            bloc: LocationPageBloc(BlocOption(query)), child: LocationPage());
      case PageName.MRTPage:
        return BlocProvider(
            bloc: MRTPageBloc(BlocOption(query)), child: MRTPage());
      case PageName.SettingPage:
        return BlocProvider(
            bloc: SettingPageBloc(BlocOption(query)), child: SettingPage());
      case PageName.SearchPage:
        return BlocProvider(
            bloc: SearchPageBloc(BlocOption(query)), child: SearchPage());
      default:
        throw ("RouteMixin 無找到對應Page");
    }
  }
}

enum TransitionEnum { normal, bottomTop, rightLeft }
