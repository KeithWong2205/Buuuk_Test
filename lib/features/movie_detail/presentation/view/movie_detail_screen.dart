import 'package:buuk_test/core/helpers/app_constants.dart';
import 'package:buuk_test/core/helpers/app_navigator.dart';
import 'package:buuk_test/core/helpers/base_state.dart';
import 'package:buuk_test/features/movie_detail/domain/model/response_movie_detail_model.dart';
import 'package:buuk_test/features/movie_detail/presentation/cubit/movie_detail_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({required this.movieId, Key? key}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends BaseState<MovieDetailScreen> {
  late ResponseMovieDetailModel loaded;
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailCubit>().getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(builder: (context, state) {
      if (state is MovieDetailInitial) {
        debugPrint("===>Movie detail initial");
      } else if (state is MovieDetailFetchSuccess) {
        loaded = state.responseMovieDetailModel;
        return Scaffold(
          appBar: _buildAppBar(context),
          body: _buildBody(context, loaded),
        );
      } else if (state is MovieDetailFetchFailed) {
        return Container(
          color: Colors.grey,
        );
      }
      return const SizedBox();
    });
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
            onPressed: () {
              AppNavigator.close(context);
            },
            icon: Icon(Icons.close))
      ],
    );
  }

  Widget _buildBody(BuildContext context, ResponseMovieDetailModel model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: AppConstants.posterLeading + model.poster_path!),
        ],
      ),
    );
  }
}
