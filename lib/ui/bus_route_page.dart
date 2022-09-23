import 'dart:math';

import 'package:bus/bloc/bus_route_page_bloc.dart';
import 'package:bus/resource/colors.dart';
import 'package:bus/route/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class BusRoutePage extends StatefulWidget {
  const BusRoutePage({Key? key}) : super(key: key);

  @override
  State<BusRoutePage> createState() => _BusRoutePageState();
}

class _BusRoutePageState extends State<BusRoutePage> {
  late BusRoutePageBloc bloc;
  final ScrollController listViewController = ScrollController();
  double opacity = 1;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<BusRoutePageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SnappingSheet(
            controller: bloc.snappingSheetController,
            lockOverflowDrag: true,
            child: Container(
              color: defaultBackgroundColor,
            ),
            grabbingHeight: 80,
            grabbing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12)),
                gradient: LinearGradient(
                  colors: const [routeBarColor1, routeBarColor2],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  stops: const [0.0, 1.0],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 10, top: 5),
                      child: Transform.rotate(
                        angle: 135 * pi / 90,
                        child: StreamBuilder<double>(
                            stream: bloc.opacityStream,
                            initialData: 1.0,
                            builder: (context, snapshot) {
                              return Opacity(
                                opacity: snapshot.requireData,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_forward_ios_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          width: 60,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(right: 10, top: 5),
                      child: StreamBuilder<double>(
                          stream: bloc.opacityStream,
                          initialData: 1.0,
                          builder: (context, snapshot) {
                            return Opacity(
                              opacity: snapshot.requireData,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
            snappingPositions: const [
              SnappingPosition.factor(
                positionFactor: 0.92,
                snappingCurve: Curves.fastLinearToSlowEaseIn,
                snappingDuration: Duration(milliseconds: 500),
                grabbingContentOffset: GrabbingContentOffset.bottom,
              ),
              SnappingPosition.factor(
                positionFactor: 0.5,
                snappingCurve: Curves.fastLinearToSlowEaseIn,
                snappingDuration: Duration(milliseconds: 500),
              ),
              SnappingPosition.factor(
                positionFactor: 0.25,
                snappingCurve: Curves.fastLinearToSlowEaseIn,
                snappingDuration: Duration(milliseconds: 500),
                grabbingContentOffset: GrabbingContentOffset.top,
              ),
            ],
            // // sheetAbove: SnappingSheetContent(
            // //   sizeBehavior: SheetSizeFill(),
            // //   draggable: false,
            // //   child: Container(
            // //     color: defaultBackgroundColor,
            // //   ),
            // // ),
            sheetBelow: SnappingSheetContent(
              draggable: true,
              child: Container(
                color: secondBackgroundColor,
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: ListView.builder(
                      itemCount: 25,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            index.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }),
                ),
              ),
            ),
            onSheetMoved: (detail) {
              if (detail.relativeToSnappingPositions > 0.35) {
                opacity = 1 - detail.relativeToSnappingPositions;
                if (opacity > 0.63) opacity = 1;
                bloc.setOpacity(opacity);
              }
            },
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, top: 20),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10, top: 20),
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.more_horiz_outlined,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
