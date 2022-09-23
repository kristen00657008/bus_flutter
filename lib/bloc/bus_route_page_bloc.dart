import 'package:bus/route/base_bloc.dart';
import 'package:bus/route/page_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class BusRoutePageBloc extends PageBloc {
  BusRoutePageBloc(BlocOption blocOption) : super(blocOption);

  final snappingSheetController = SnappingSheetController();

  /// opacity
  final BehaviorSubject<double> _opacitySubject =
  BehaviorSubject.seeded(0);

  Stream<double> get opacityStream => _opacitySubject.stream;

  void setOpacity(double opacity) {
    _opacitySubject.add(opacity);
  }
}