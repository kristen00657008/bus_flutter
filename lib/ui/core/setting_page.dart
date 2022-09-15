import 'package:flutter/material.dart';
import 'package:bus/bloc/core/setting_page_bloc.dart';
import 'package:bus/route/base_bloc.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late SettingPageBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SettingPageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.toString(),style: TextStyle(color: Colors.white),),
    );
  }
}
