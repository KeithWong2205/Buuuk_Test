import 'package:buuk_test/core/helpers/app_constants.dart';
import 'package:buuk_test/core/helpers/app_navigator.dart';
import 'package:buuk_test/core/helpers/base_state.dart';
import 'package:buuk_test/core/helpers/platform_png.dart';
import 'package:buuk_test/features/movie_detail/domain/model/response_movie_detail_model.dart';
import 'package:buuk_test/features/movie_detail/presentation/cubit/movie_detail_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailScreen({required this.movieId, Key? key}) : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends BaseState<MovieDetailScreen> {
  ResponseMovieDetailModel loaded = ResponseMovieDetailModel();
  @override
  void initState() {
    super.initState();
    context.read<MovieDetailCubit>().getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailCubit, MovieDetailState>(builder: (context, state) {
      if (state is MovieDetailFetchSuccess) {
        loaded = state.responseMovieDetailModel;
      }
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(context),
        body: (state is MovieDetailInitial)
            ? _buildLoader()
            : (state is MovieDetailFetchFailed)
                ? _buildPlaceHolder()
                : _buildBody(context, loaded),
      );
    });
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          SizedBox(width: 60, child: PlatformPng.asset('buuk_logo', fit: BoxFit.scaleDown)),
          const Text(
            " | Movie Details",
            style: AppConstants.appBarStyle,
          ),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {
              AppNavigator.close(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.black,
              size: 20,
            ))
      ],
    );
  }

  Widget _buildPlaceHolder() => const Center(child: Text("No Information Found"));

  Widget _buildLoader() => const Center(child: CircularProgressIndicator());

  Widget _buildBody(BuildContext context, ResponseMovieDetailModel model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: AppConstants.backdropLeading + model.backdrop_path!,
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 160,
            child: _buildGeneralSection(model),
          ),
          const SizedBox(height: 10),
          const Divider(
            thickness: 1,
            height: 3,
            color: Colors.red,
          ),
          const SizedBox(height: 10),
          Text(
            "Overview",
            style: AppConstants.bodyStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                Text(
                  model.overview!,
                  style: AppConstants.bodyStyle.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      "Genres: ",
                      style: AppConstants.bodyStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ...model.genres!.map((e) => Text(
                          "${e.name!}, ",
                          style: AppConstants.bodyStyle.copyWith(fontSize: 14, fontStyle: FontStyle.italic),
                        ))
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  thickness: 1,
                  height: 3,
                  color: Colors.red,
                ),
                const SizedBox(height: 10),
                Text(
                  "Productions:",
                  style: AppConstants.bodyStyle.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 100,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...model.production_companies!.map(
                        (e) => e.logo_path != null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: SizedBox(
                                  width: 100,
                                  child: CachedNetworkImage(
                                    imageUrl: AppConstants.posterLeading + e.logo_path!,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Individual Widget methods
  Row _buildGeneralSection(ResponseMovieDetailModel model) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CachedNetworkImage(
          imageUrl: AppConstants.posterLeading + model.poster_path!,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              model.title!,
              style: AppConstants.bodyStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(height: 10),
            model.tagline != null
                ? Text(
                    "\"${model.tagline!}\"",
                    maxLines: 2,
                    style: AppConstants.bodyStyle.copyWith(fontSize: 12, fontStyle: FontStyle.italic),
                  )
                : const SizedBox(),
            const Spacer(),
            _buildStatisticSection(model),
            const SizedBox(height: 10),
          ],
        ),
      ],
    );
  }

  Row _buildStatisticSection(ResponseMovieDetailModel model) {
    return Row(
      children: [
        Column(
          children: [
            Row(
              children: [
                Text(
                  "Popularity: ",
                  style: AppConstants.bodyStyle.copyWith(fontSize: 12),
                ),
                model.popularity != null
                    ? Text(
                        "${model.popularity}",
                        style: AppConstants.bodyStyle.copyWith(
                            fontSize: 12,
                            color: model.popularity! >= 3500
                                ? Colors.green
                                : (model.popularity! < 3500 && model.popularity! >= 1500)
                                    ? Colors.amber
                                    : Colors.red),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Revenue: ",
                  style: AppConstants.bodyStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                model.revenue != null
                    ? Text(
                        "\$ ${model.revenue}",
                        style: AppConstants.bodyStyle.copyWith(
                          color: Colors.greenAccent,
                          fontSize: 12,
                        ),
                      )
                    : const SizedBox(),
              ],
            )
          ],
        ),
        const SizedBox(width: 15),
        Column(
          children: [
            Row(
              children: [
                Text(
                  "Average score: ",
                  style: AppConstants.bodyStyle.copyWith(fontSize: 12),
                ),
                model.vote_average != null
                    ? Text(
                        "${model.vote_average}",
                        style: AppConstants.bodyStyle.copyWith(
                          fontSize: 12,
                          color: model.vote_average! >= 5.0 ? Colors.green : Colors.red,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Runtime: ",
                  style: AppConstants.bodyStyle.copyWith(
                    fontSize: 12,
                  ),
                ),
                model.runtime != null
                    ? Text(
                        "${model.runtime} minutes",
                        style: AppConstants.bodyStyle.copyWith(
                          color: Colors.cyan,
                          fontSize: 12,
                        ),
                      )
                    : const SizedBox(),
              ],
            )
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
