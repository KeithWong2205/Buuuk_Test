import 'package:buuk_test/core/helpers/app_navigator.dart';
import 'package:buuk_test/core/helpers/base_state.dart';
import 'package:buuk_test/features/movie_detail/presentation/cubit/movie_detail_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({required this.movieId, Key? key}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends BaseState<MovieDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailCubit>().getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Movie Detail"),
      actions: [
        IconButton(
            onPressed: () {
              AppNavigator.close(context);
            },
            icon: Icon(Icons.close))
      ],
    );
  }
}
