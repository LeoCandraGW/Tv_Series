import 'package:TV_Series/data/datasources/db/database_helper_tv.dart';
import 'package:TV_Series/data/datasources/tv_local_data_source.dart';
import 'package:TV_Series/data/datasources/tv_remote_data_source.dart';
import 'package:TV_Series/domain/repositories/tv_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TvRepository,
  TvRemoteDataSource,
  TvLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
