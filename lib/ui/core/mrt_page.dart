import 'package:flutter/material.dart';
import 'package:bus/bloc/core/mrt_page_bloc.dart';
import 'package:bus/route/base_bloc.dart';

class MRTPage extends StatefulWidget {
  const MRTPage({Key? key}) : super(key: key);

  @override
  State<MRTPage> createState() => _MRTPageState();
}

class _MRTPageState extends State<MRTPage> {
  late MRTPageBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<MRTPageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.toString(),style: TextStyle(color: Colors.white),),
    );
  }
}
