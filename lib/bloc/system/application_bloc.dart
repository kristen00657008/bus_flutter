import 'package:bus/route/page_name.dart';
import 'package:bus/route/route_data.dart';
import 'package:bus/route/route_mixin.dart';
import 'package:rxdart/rxdart.dart';

class ApplicationBloc with RouteMixin {

  static final _singleton = ApplicationBloc._internal();

  static ApplicationBloc getInstance() => _singleton;

  factory ApplicationBloc() => _singleton;

  ApplicationBloc._internal() {
    addSubPageRoute(RouteData(PageName.HomePage));
  }

  /// 頁面歷史紀錄
  final List<RouteData> _subPageHistory = [];

  String? get lastSubPage => _subPageSubject.value.routeName;

  /// 紀錄當前頁面
  final BehaviorSubject<RouteData> _subPageSubject = BehaviorSubject.seeded(RouteData(''));

  Stream<RouteData> get subPageStream => _subPageSubject.stream;

  void addSubPageRoute(RouteData routeData) {
    _subPageSubject.add(routeData);
  }

  void popSubPage() {
    if(_subPageHistory.length>1) {
      _subPageHistory.removeLast();
    }

    if(!_subPageHistory.last.addHistory) {
      _subPageHistory.removeLast();
    }

    _subPageSubject.add(_subPageHistory.last);
  }

  /// 關閉
  void dispose() {
    _subPageSubject.close();
  }

}