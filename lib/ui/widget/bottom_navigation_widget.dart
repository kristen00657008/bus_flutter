import 'package:bus/resource/colors.dart';
import 'package:flutter/material.dart';
import 'package:bus/model/system/bottom_navigation_data.dart';
import 'package:bus/ui/widget/material_ink_widget.dart';

typedef BottomTapCallback = void Function(BottomNavigationData data);

class BottomNavigationWidget extends StatelessWidget {
  final List<BottomNavigationData> bottomNavigationList;

  final String currentRouteName;

  final BottomTapCallback onTap;

  const BottomNavigationWidget(
      {Key? key,
      required this.bottomNavigationList,
      required this.currentRouteName,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      explicitChildNodes: true,
      child: Material(
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Column(
            children: [
              Divider(
                height: 0.5,
                color: Colors.black,
              ),
              Expanded(
                  child: Row(
                children: bottomNavigationList
                    .map((e) => _buildItemWidget(e))
                    .toList(),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItemWidget(BottomNavigationData data) {
    bool isSelected =
        currentRouteName.isNotEmpty && data.url.contains(currentRouteName);

    Color iconColor = isSelected ? buttonDefaultColor : buttonDisableColor;

    Widget commonWidget = SizedBox.expand(
      child: Container(
          color: defaultBackgroundColor,
          child: Icon(
            data.icon,
            color: iconColor,
            size: 35,
          )),
    );

    return Expanded(
      child: MaterialInkWidget(
        onTap: () => onTap(data),
        canSplash: false,
        child: commonWidget,
      ),
    );
  }
}
