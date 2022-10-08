import 'package:buuk_test/core/base/cubit/device_info_cubit.dart';
import 'package:buuk_test/core/helpers/app_constants.dart';
import 'package:buuk_test/core/helpers/app_navigator.dart';
import 'package:buuk_test/core/helpers/app_utils.dart';
import 'package:buuk_test/core/helpers/base_state.dart';
import 'package:buuk_test/features/movie_detail/presentation/view/movie_detail_screen.dart';
import 'package:buuk_test/navigation/navigation_center.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:buuk_test/features/movie_list/domain/model/result_movie_item_model.dart';
import 'package:buuk_test/features/movie_list/presentation/cubit/movie_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HomeMovieListScreen extends StatefulWidget {
  const HomeMovieListScreen({Key? key}) : super(key: key);

  @override
  _HomeMovieListScreenState createState() => _HomeMovieListScreenState();
}

class _HomeMovieListScreenState extends BaseState<HomeMovieListScreen> {
  List<ResultMovieItemModel> loaded = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    context.read<DeviceInfoCubit>().getVersionBuildInfo();
    context.read<MovieListCubit>().getNowPlayingMovies(page);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListCubit, MovieListState>(
      builder: (context, state) {
        if (state is MovieListInitial) {
          EasyLoading.show();
          debugPrint("===> Movie List initial");
          return Scaffold(
            appBar: _buildAppBar(context),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is MovieListFetchSuccess) {
          loaded.addAll(state.responseMovieListModel.results!);
          return Scaffold(
            appBar: _buildAppBar(context),
            body: _buildBody(context, loaded),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                page += 1;
                context.read<MovieListCubit>().getNowPlayingMovies(page);
              },
              child: Icon(Icons.add),
            ),
          );
        } else if (state is MovieListFetchFailed) {
          return Container(
            color: Colors.grey,
          );
        }
        return const SizedBox();
      },
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: const Text("Buuk Now Playing"),
    );
  }

  Widget _buildBody(BuildContext context, List<ResultMovieItemModel> moviesList) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: moviesList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                AppNavigator.goToScreen(
                    this,
                    MovieDetailScreen(
                      movieId: moviesList[index].id!,
                    ),
                    NavigationCenter.movieDetailScreen);
              },
              child: Row(
                children: [
                  SizedBox(
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: AppConstants.posterLeading + moviesList[index].poster_path!,
                        filterQuality: FilterQuality.low,
                      )),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        moviesList[index].title!,
                        textAlign: TextAlign.center,
                      ),
                      Text(moviesList[index].release_date!),
                    ],
                  ))
                ],
              ),
            ),
          );
        });
  }
}
