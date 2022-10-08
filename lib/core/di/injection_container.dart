import 'package:buuk_test/core/api/service/base/rest_service.dart';
import 'package:buuk_test/core/base/cubit/device_info_cubit.dart';
import 'package:buuk_test/core/di/module/network_module.dart';
import 'package:buuk_test/core/helpers/secure_storage.dart';
import 'package:buuk_test/features/movie_detail/data/movie_detail_datasource.dart';
import 'package:buuk_test/features/movie_detail/domain/repository/movie_detail_repository.dart';
import 'package:buuk_test/features/movie_detail/domain/usecase/get_movie_detail_case.dart';
import 'package:buuk_test/features/movie_detail/presentation/cubit/movie_detail_cubit.dart';
import 'package:buuk_test/features/movie_list/data/movie_list_data_source.dart';
import 'package:buuk_test/features/movie_list/domain/repository/movie_list_repository.dart';
import 'package:buuk_test/features/movie_list/domain/usecase/get_now_playing_list_case.dart';
import 'package:buuk_test/features/movie_list/presentation/cubit/movie_list_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

//Init injection container
Future<void> init() async {
  //DateSource and Repository
  sl.registerLazySingleton<MovieListDataSource>(
    () => MovieListDataSourceImpl(restService: sl()),
  );

  sl.registerLazySingleton<MovieListRepository>(
    () => MovieListRepositoryImpl(movieListDataSource: sl()),
  );

  sl.registerLazySingleton<MovieDetailDatasource>(
    () => MovieDetailDataSourceImpl(restService: sl()),
  );

  sl.registerLazySingleton<MovieDetailRepository>(
    () => MovieDetailRepositoryImpl(movieDetailDatasource: sl()),
  );

  //Use case
  sl.registerLazySingleton<GetNowPlayingListCase>(
    () => GetNowPlayingListCase(movieListRepository: sl()),
  );

  sl.registerLazySingleton<GetMovieDetailCase>(
    () => GetMovieDetailCase(movieDetailRepository: sl()),
  );

  //Cubit
  sl.registerLazySingleton<DeviceInfoCubit>(
    () => DeviceInfoCubit(),
  );

  sl.registerLazySingleton<MovieListCubit>(
    () => MovieListCubit(getNowPlayingListCase: sl()),
  );

  sl.registerLazySingleton<MovieDetailCubit>(
    () => MovieDetailCubit(getMovieDetailCase: sl()),
  );

  // Services
  sl.registerLazySingleton<RestService>(() => RestService(sl()));

  // Other
  sl.registerLazySingleton<SecureStorage>(() => SecureStorage());
  sl.registerLazySingleton<Dio>(() => NetworkModule.provideDio());
}
