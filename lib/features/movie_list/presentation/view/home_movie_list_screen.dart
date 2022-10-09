import 'package:buuk_test/core/base/cubit/device_info_cubit.dart';
import 'package:buuk_test/core/helpers/app_constants.dart';
import 'package:buuk_test/core/helpers/app_navigator.dart';
import 'package:buuk_test/core/helpers/app_utils.dart';
import 'package:buuk_test/core/helpers/base_state.dart';
import 'package:buuk_test/core/helpers/platform_png.dart';
import 'package:buuk_test/features/movie_detail/presentation/view/movie_detail_screen.dart';
import 'package:buuk_test/navigation/navigation_center.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:buuk_test/features/movie_list/domain/model/result_movie_item_model.dart';
import 'package:buuk_test/features/movie_list/presentation/cubit/movie_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeMovieListScreen extends StatefulWidget {
  const HomeMovieListScreen({Key? key}) : super(key: key);

  @override
  _HomeMovieListScreenState createState() => _HomeMovieListScreenState();
}

class _HomeMovieListScreenState extends BaseState<HomeMovieListScreen> {
  //Variable and constants
  DateFormat parsingFormat = DateFormat('yyyy-mm-dd');
  DateFormat showingFormat = DateFormat('dd MMM yyyy');
  final _scrollController = ScrollController();
  List<ResultMovieItemModel> loaded = [];
  int page = 1;

  //InitState
  @override
  void initState() {
    loaded.clear();
    super.initState();
    context.read<DeviceInfoCubit>().getVersionBuildInfo();
    context.read<MovieListCubit>().getNowPlayingMovies(page);
  }

  //Main Build method
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieListCubit, MovieListState>(
      builder: (context, state) {
        if (state is MovieListFetchSuccess) {
          AppUtils.showToastMessage("Loaded successfully");
          if (page == 1) {
            loaded.clear();
          }
          loaded.addAll(state.responseMovieListModel.results!);
        } else if (state is MovieListFetchFailed) {
          AppUtils.showToastMessage("Failed to load, try again later");
        }
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: _buildAppBar(context),
          body: (state is MovieListInitial)
              ? _buildLoader()
              : (state is MovieListFetchFailed)
                  ? _buildPlaceHolder()
                  : _buildBody(context, loaded),
          floatingActionButton: (state is MovieListFetchSuccess) ? _buildButtonSet(context) : null,
        );
      },
    );
  }

  //Building Individual Widget
  Widget _buildPlaceHolder() => const Center(child: Text("No Movies Found"));

  Widget _buildLoader() => const Center(child: CircularProgressIndicator());

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: [
          SizedBox(width: 60, child: PlatformPng.asset('buuk_logo', fit: BoxFit.scaleDown)),
          const Text(
            " | Now Playing",
            style: AppConstants.appBarStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, List<ResultMovieItemModel> moviesList) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          controller: _scrollController,
          itemCount: moviesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: movieItem(moviesList, index),
            );
          }),
    );
  }

  Widget _buildButtonSet(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        FloatingActionButton.extended(
          onPressed: () {
            _scrollController.animateTo(0, duration: const Duration(milliseconds: 1000), curve: Curves.ease);
          },
          backgroundColor: Colors.white.withOpacity(0.8),
          foregroundColor: Colors.red,
          label: const Text(
            "Top",
            style: TextStyle(fontSize: 12),
          ),
          icon: const Icon(
            Icons.arrow_upward,
            size: 18,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        FloatingActionButton.extended(
          onPressed: () {
            page += 1;
            context.read<MovieListCubit>().getNowPlayingMovies(page);
          },
          backgroundColor: Colors.white.withOpacity(0.8),
          foregroundColor: Colors.green,
          label: const Text(
            "Load more",
            style: TextStyle(fontSize: 12),
          ),
          icon: const Icon(
            Icons.add,
            size: 18,
          ),
        ),
      ],
    );
  }

  Widget movieItem(List<ResultMovieItemModel> moviesList, int index) {
    return GestureDetector(
      onTap: () {
        AppNavigator.goToScreen(
            this,
            MovieDetailScreen(
              movieId: moviesList[index].id!,
            ),
            NavigationCenter.movieDetailScreen);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.srcOver),
            child: SizedBox(
                child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: AppConstants.backdropLeading + moviesList[index].backdrop_path!,
            )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 20),
              SizedBox(
                  height: 150,
                  child: Hero(
                    tag: moviesList[index].poster_path!,
                    child: CachedNetworkImage(
                      imageUrl: AppConstants.posterLeading + moviesList[index].poster_path!,
                      filterQuality: FilterQuality.low,
                    ),
                  )),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    moviesList[index].title!,
                    style: AppConstants.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Popularity: ',
                        style: AppConstants.bodyStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        '${moviesList[index].popularity}',
                        style: AppConstants.bodyStyle.copyWith(
                            fontSize: 14,
                            color: moviesList[index].popularity! >= 3500
                                ? Colors.green
                                : (moviesList[index].popularity! < 3500 && moviesList[index].popularity! >= 1500)
                                    ? Colors.amber
                                    : Colors.red),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Average score: ',
                        style: AppConstants.bodyStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        '${moviesList[index].vote_average}',
                        style: AppConstants.bodyStyle.copyWith(
                            fontSize: 14, color: moviesList[index].vote_average! >= 5.0 ? Colors.green : Colors.red),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Released on: ',
                        style: AppConstants.bodyStyle.copyWith(fontSize: 14),
                      ),
                      Text(
                        '${showingFormat.format(parsingFormat.parse(moviesList[index].release_date!))}',
                        style: AppConstants.bodyStyle.copyWith(fontSize: 14, color: Colors.cyan),
                      )
                    ],
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}
