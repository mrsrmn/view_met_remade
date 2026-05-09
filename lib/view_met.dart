import 'package:flutter/material.dart';

import 'features/piece/presentation/pages/piece_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ViewMet extends StatefulWidget {
  final Widget page;

  const ViewMet({Key? key, required this.page}) : super(key: key);

  @override
  State<ViewMet> createState() => _ViewMetState();
}

class _ViewMetState extends State<ViewMet> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Handles warm start deep links (app already running, widget tapped)
  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    final uriString = routeInformation.uri.toString();
    final uri = Uri.tryParse(uriString);

    // Intercept all viewmet:// URLs to prevent default routing
    if (uri != null && uri.scheme == 'viewmet') {
      final id = _extractPieceId(uriString);
      if (id != null) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(builder: (_) => PiecePage(id: id)),
        );
      }
      // Always return true for viewmet:// to prevent fallthrough to onGenerateRoute
      return Future.value(true);
    }
    return super.didPushRouteInformation(routeInformation);
  }

  /// Extracts piece ID from a viewmet:// deep link URL
  static int? _extractPieceId(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null) return null;
    if (uri.scheme == 'viewmet' && uri.host == 'piece') {
      final segments = uri.pathSegments;
      if (segments.isNotEmpty) {
        final id = int.tryParse(segments.first);
        if (id != null && id > 0) return id;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "ViewMET",
      theme: ThemeData(
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(builder: (_) => widget.page);
      },
      // Handles cold start deep links (app launched via widget tap)
      onGenerateInitialRoutes: (initialRoute) {
        final id = _extractPieceId(initialRoute);
        if (id != null) {
          return [
            MaterialPageRoute(builder: (_) => widget.page),
            MaterialPageRoute(builder: (_) => PiecePage(id: id)),
          ];
        }
        return [MaterialPageRoute(builder: (_) => widget.page)];
      },
    );
  }
}
