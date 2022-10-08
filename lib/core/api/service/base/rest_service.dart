import 'package:buuk_test/core/api/service/base/rest_client.dart';
import 'package:buuk_test/core/base/model/response_base_model.dart';
import 'package:buuk_test/features/movie_detail/domain/model/response_movie_detail_model.dart';
import 'package:buuk_test/features/movie_list/domain/model/response_movie_list_model.dart';
import 'package:dio/dio.dart';

class RestService {
  final Dio _dio;

  RestService(this._dio);

  Future<ResponseMovieListModel> getNowPlayingMovies(int page) async {
    Map<String, dynamic> data = {};
    data['api_key'] = "a67a1892b7a906a0b14c396efa3502eb";
    data['page'] = page;
    return await RestClient(_dio).getNowPlayingMovies(data);
  }

  Future<ResponseMovieDetailModel> getMovieDetail(int movieId) async {
    return ResponseMovieDetailModel();
  }
}
