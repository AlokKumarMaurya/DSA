import 'package:chat_application/utils/dependency_injection/inject_getX_controllers.dart';
import 'package:chat_application/utils/logger/logger.dart';

class InjectDependency {
  static final InjectDependency _injectDependency =
      InjectDependency._internal();

  InjectDependency._internal(){
    Logger.log(mes: "Injecting Dependencies");
    InjectGetXControllers();
  }

  factory InjectDependency() {
    return _injectDependency;
  }
}
