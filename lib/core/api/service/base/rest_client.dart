import 'package:buuk_test/core/base/model/response_base_model.dart';
import 'package:buuk_test/core/helpers/global_configs.dart';
import 'package:buuk_test/features/movie_list/domain/model/response_movie_list_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: GlobalConfig.baseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET("movie/now_playing")
  Future<ResponseMovieListModel> getNowPlayingMovies(@Queries() Map<String, dynamic> map);

  @GET("movie/{movieId}")
  Future<ResponseBaseModel> getMovieDetail(@Path() String movieId, @Queries() Map<String, dynamic> map);
}
