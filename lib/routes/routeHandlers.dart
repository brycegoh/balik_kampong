import 'package:balik_kampong/screens/splashscreen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import '../screens/navbar/home.dart';
import '../screens/auth/login.dart';
import '../screens/auth/signup.dart';
import '../screens/forms/onboard.dart';
import '../screens/navbar/app.dart';
import '../screens/events/browseEvent.dart';
import '../screens/communities/browseCommunities.dart';
import '../screens/events/event.dart';
import '../screens/forms/dynamicForm.dart';
import '../screens/settings/settings.dart';
import '../screens/sos/sos.dart';
import '../screens/webview/webview.dart';
// var noRouteHandler =
//     Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
//   return PathErrorScreen();
// });

var rootHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
  return SplashScreen();
});

var loginHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
  return LoginScreen();
});

var onboardHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
  return OnboardScreen();
});

var signupHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
  return SignupScreen();
});

var homeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
  return AppScreen(
    tabIndex: 0,
  );
});

var communitiesHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
  return HomeScreen();
});

var eventsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
  return BrowseEventScreen();
});

var communityHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>>? params) {
  return BrowseCommunitiesScreen();
});

var specificEventHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String eventId = params["eventId"]!.first;
  return EventScreen(eventId: int.parse(eventId));
});

var dynamicformHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String formId = params["formId"]!.first;
  return DynamicFormScreen(formId: int.parse(formId));
});

var settingsHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  return SettingsScreen();
});

var webviewHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String? url = params["url"]?.first;
  return WebViewScreen(url: url);
});

var sosHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
  String countryId = params["countryId"]!.first;
  return SosScreen(countryId: int.parse(countryId));
});
