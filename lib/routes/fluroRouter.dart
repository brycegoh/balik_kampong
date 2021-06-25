import 'package:fluro/fluro.dart';
import './routes.dart';

// Storing Fluro initialised router object
class PowerPuffRouter {
  static late final FluroRouter powerRouter;

  static initRouter() {
    final router = FluroRouter();
    Routes.setupRouter(router);
    powerRouter = router;
  }
}
