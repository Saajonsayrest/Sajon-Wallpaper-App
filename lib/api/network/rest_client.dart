import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:untitled1/feature/dashboard/models/homepage_model.dart';

part 'rest_client.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('search')
  Future<HomepageModel> getHomepage({
    @Query('query') String? searchQuery = 'all',
    @Query('per_page') int? perPage = 100,
  });
}
