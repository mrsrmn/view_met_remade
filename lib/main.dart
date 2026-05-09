import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_widget/home_widget.dart';
import 'package:workmanager/workmanager.dart';
import 'package:view_met_remade/view_met.dart';
import 'core/pages/home_page.dart';
import 'features/aotd/presentation/bloc/aotd_bloc.dart';
import 'features/collections/presentation/bloc/collections_bloc.dart';
import 'features/departments/presentation/bloc/department_bloc.dart';
import 'features/favorite/presentation/bloc/favorites_bloc.dart';
import 'features/notifications/presentation/bloc/notification_settings_bloc.dart';
import 'features/piece/presentation/bloc/piece_bloc.dart';

import 'core/injectors/injection_container_piece.dart' as pc; // Piece Injection Container
import 'core/injectors/injection_container_general.dart' as gc; // General Injection Container
import 'core/injectors/injection_container_favorite.dart' as fc; // Favorites Injection Container
import 'core/injectors/injection_container_department.dart' as dc; // Departments Injection Container
import 'core/injectors/injection_container_collections.dart' as cc; // Collections Injection Container
import 'core/injectors/injection_container_notifications.dart' as nc; // Notifications Injection Container
import 'core/injectors/injection_container_aotd.dart' as ac; // AOTD Injection Container

import 'features/aotd/data/background/aotd_background_callback.dart';
import 'features/notifications/data/datasources/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  // Initialize WorkManager for AOTD background refresh (Android only)
  if (Platform.isAndroid) {
    Workmanager().initialize(aotdCallbackDispatcher);
    Workmanager().registerPeriodicTask(
      aotdTaskName,
      aotdTaskName,
      frequency: const Duration(hours: 24),
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  // Initialize HomeWidget
  await HomeWidget.setAppGroupId('group.com.duna.viewmet');

  // Initialize Injection Containers
  await pc.init();
  await gc.init();
  await fc.init();
  await dc.init();
  await cc.init();
  await ac.init();
  await nc.init();

  // Initialize notification service
  final notificationService = nc.sl<NotificationService>();
  await notificationService.initialize();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => pc.sl<PieceBloc>()
      ),
      BlocProvider(
        create: (context) => fc.sl<FavoritesBloc>()
      ),
      BlocProvider(
        create: (context) => dc.sl<DepartmentBloc>()
      ),
      BlocProvider(
        create: (context) => cc.sl<CollectionsBloc>()
      ),
      BlocProvider(
        create: (context) => nc.sl<NotificationSettingsBloc>()
      ),
      BlocProvider(
        create: (context) => ac.sl<AotdBloc>()
      ),
    ],
    child: ViewMet(page: HomePage()),
  ));
}
