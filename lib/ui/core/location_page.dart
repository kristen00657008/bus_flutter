import 'package:flutter/material.dart';
import 'package:bus/bloc/core/location_page_bloc.dart';
import 'package:bus/route/base_bloc.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  late LocationPageBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<LocationPageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.toString(),style: TextStyle(color: Colors.white),),
    );
  }
}
