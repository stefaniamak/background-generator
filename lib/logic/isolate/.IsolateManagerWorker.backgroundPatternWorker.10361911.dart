import 'background_pattern_isolate.dart';
import 'package:isolate_manager/isolate_manager.dart';

main() {
  IsolateManagerFunction.customWorkerFunction(backgroundPatternWorker);
}
