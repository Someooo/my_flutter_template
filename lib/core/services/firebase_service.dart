import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class FirebaseService {
  FirebaseAnalytics get analytics => FirebaseAnalytics.instance;
  FirebaseCrashlytics get crashlytics => FirebaseCrashlytics.instance;

  Future<void> initialize() async {
    await analytics.setAnalyticsCollectionEnabled(true);
    await crashlytics.setCrashlyticsCollectionEnabled(true);
  }
}
