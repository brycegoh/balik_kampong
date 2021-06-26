import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './routeHandlers.dart';

class Routes {
  static void setupRouter(FluroRouter router) {
    router.define("/", handler: rootHandler);
    router.define("/home", handler: homeHandler);
    router.define("/onboard", handler: onboardHandler);
    router.define("/login", handler: loginHandler);
    router.define("/sign-up", handler: signupHandler);
    router.define("/browse-events", handler: eventsHandler);
    router.define("/browse-communities", handler: communityHandler);
    router.define("/event", handler: specificEventHandler);
  }
}
