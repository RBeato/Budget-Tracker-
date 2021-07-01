import 'package:envify/envify.dart';

part 'env.g.dart';

@Envify()
abstract class Env {
  static const notionApiKey = _Env.notionApiKey;
  static const notionDatabaseKey = _Env.notionDatabaseKey;
}
