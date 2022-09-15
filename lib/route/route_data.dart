class RouteData {

  String routeName;

  Map<String, dynamic> blocQuery;

  bool addHistory;

  RouteData(
    this.routeName, {
    this.blocQuery = const {},
    this.addHistory = true,
  });

}