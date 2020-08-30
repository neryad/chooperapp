import 'package:chopper/chopper.dart';
part 'post_service.chopper.dart';

//final String ApiUrl = conf.CONFIG['API_URL'];
@ChopperApi(baseUrl: '/posts')
abstract class PostService extends ChopperService {
  @Get()
  Future<Response> getPosts();

  @Get(path: '/{id}')
  Future<Response> getPost(@Path('id') int id);
  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static PostService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [
        _$PostService(),
      ],
      converter: JsonConverter(),
    );

    return _$PostService(client);
  }
}
