import 'package:buuk_test/core/api/service/base/rest_client.dart';
import 'package:buuk_test/core/base/model/response_base_model.dart';
import 'package:buuk_test/core/helpers/global_configs.dart';
import 'package:buuk_test/features/movie_detail/domain/model/response_movie_detail_model.dart';
import 'package:buuk_test/features/movie_list/domain/model/response_movie_list_model.dart';
import 'package:dio/dio.dart';

class RestService {
  final Dio _dio;

  RestService(this._dio);

  Future<ResponseMovieListModel> getNowPlayingMovies(int page) async {
    Map<String, dynamic> data = {};
    data['api_key'] = GlobalConfig.api_Key;
    data['page'] = page;
    return await RestClient(_dio).getNowPlayingMovies(data);
  }

  Future<ResponseMovieDetailModel> getMovieDetail(int movieId) async {
    Map<String, dynamic> queryData = {};
    queryData['api_key'] = GlobalConfig.api_Key;
    return await RestClient(_dio).getMovieDetail(movieId, queryData);
  }
}
