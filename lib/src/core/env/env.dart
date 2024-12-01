import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'PROJECT_URL', obfuscate: true)
  static final String projectUrl = _Env.projectUrl;

  @EnviedField(varName: 'ANON_KEY', obfuscate: true)
  static final String anonKey = _Env.anonKey;

  @EnviedField(varName: 'Mistral_API', obfuscate: true)
  static final String mistralApi = _Env.mistralApi;
}
