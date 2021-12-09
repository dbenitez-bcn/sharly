import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:sharlyapp/sharly.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MobileAds.instance.initialize();
  // TODO: Add test devices ids
  // MobileAds.instance.updateRequestConfiguration(RequestConfiguration(testDeviceIds: []));
  runApp(const Sharly());
}
