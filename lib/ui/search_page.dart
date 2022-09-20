import 'package:bus/bloc/search_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:bus/route/base_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchPageBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<SearchPageBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(widget.toString(),style: TextStyle(color: Colors.white),),
    );
  }
}
