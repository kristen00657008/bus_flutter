import 'package:flutter/material.dart';

class MaterialInkWidget extends StatelessWidget {
  /// 點擊事件
  final GestureTapCallback? onTap;

  /// 水波紋顏色
  final Color? splashColor;

  /// 背景色
  final Color? backgroundColor;

  /// 顯示元件
  final Widget child;

  final bool canSplash;

  const MaterialInkWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.splashColor,
    this.backgroundColor,
    this.canSplash = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Material(
        key: key,
        color: Colors.transparent,
        child: InkWell(
          splashFactory: canSplash ? null : NoSplash.splashFactory,
          splashColor: splashColor,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
