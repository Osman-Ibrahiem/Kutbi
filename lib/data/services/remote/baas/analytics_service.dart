import 'package:flutter/widgets.dart';

abstract class AnalyticsService {
  Future<void> logEvent(String name, {Map<String, Object>? parameters});

  Future<void> setUserId(String id);

  Future<void> logScreenView(String screenName);

  NavigatorObserver get observer;
}
