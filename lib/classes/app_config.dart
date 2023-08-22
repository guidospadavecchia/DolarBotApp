import '../main_common.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

enum AppFlavor { Lite, Pro }

class AppLogo {
  final String border = "assets/images/logos/border/logo.png";
  final String borderless = "assets/images/logos/borderless/logo.png";

  const AppLogo._create();
}

class AppConfig extends InheritedWidget {
  static const String appDisplayName = "DolarBot";
  static const AppLogo logo = const AppLogo._create();
  static late final bool isProVersion;
  final AppFlavor flavor;
  late final String appName;
  late final String packageName;
  late final int appInternalId;
  late final String version;

  AppConfig._initialize({
    required this.flavor,
    required DolarBotApp app,
    required PackageInfo packageInfo,
  }) : super(child: app) {
    this.appName = packageInfo.appName;
    this.appInternalId = flavor == AppFlavor.Lite ? 1 : 2;
    this.packageName = packageInfo.packageName;
    this.version = packageInfo.version;
    isProVersion = flavor == AppFlavor.Pro;
  }

  static Future<AppConfig> initialize({
    required AppFlavor flavor,
    required DolarBotApp child,
  }) async {
    PackageInfo pInfo = await PackageInfo.fromPlatform();
    return AppConfig._initialize(
      flavor: flavor,
      app: child,
      packageInfo: pInfo,
    );
  }

  String getFlavorValue() {
    return this.flavor.toString().split(".").last;
  }

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>()!;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
