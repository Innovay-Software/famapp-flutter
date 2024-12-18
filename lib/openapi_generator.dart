// Openapi Generator last run: : 2024-12-18T00:26:58.803603
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';

@Openapi(
  additionalProperties: DioProperties(
    pubName: 'famapp_api',
    pubAuthor: 'LD',
  ),
  inputSpec: InputSpec(path: 'openapi_spec/apiMain.yaml'),
  generatorName: Generator.dio,
  runSourceGenOnOutput: true,
  outputDirectory: 'openapi_gen',
  skipIfSpecIsUnchanged: false,
)
class OpenapiGenerator {}