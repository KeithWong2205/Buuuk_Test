import 'package:flutter/material.dart';

class HomeMovieListScreen extends StatefulWidget {
  const HomeMovieListScreen({Key? key}) : super(key: key);

  @override
  _HomeMovieListScreenState createState() => _HomeMovieListScreenState();
}

class _HomeMovieListScreenState extends State<HomeMovieListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: const Text("Buuk Now Playing"),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Colors.red,
    );
  }
}
