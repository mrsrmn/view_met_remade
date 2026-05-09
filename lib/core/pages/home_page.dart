import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/aotd/presentation/bloc/aotd_bloc.dart';
import '../../features/aotd/presentation/widgets/aotd_card_widget.dart';
import '../pages/search_results_page.dart';
import '../widgets/collections_button.dart';
import '../widgets/favorites_button.dart';
import '../widgets/settings_button.dart';
import '../widgets/view_met_image.dart';
import '../widgets/departments_list_widget.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AotdBloc>().add(OnAotdRequestedEvent());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 80,
        backgroundColor: Colors.transparent,
        flexibleSpace: const ViewMetImage(),
        title: SizedBox(
          height: 36,
          child: TextField(
            controller: _controller,
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: InputDecoration(
              prefixIcon: Icon(CupertinoIcons.search, size: 20, color: Colors.white.withOpacity(0.6)),
              hintText: "Search ViewMET",
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
              filled: true,
              fillColor: Colors.white.withOpacity(0.2),
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultsPage(query: value.trim()),
                  ),
                );
              }
            },
          ),
        ),
        actions: const [
          CollectionsButton(),
          FavoriteButton(),
          SettingsButton(),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const AotdCardWidget(),
            const Expanded(child: DepartmentsListWidget()),
          ],
        ),
      ),
      ),
    );
  }
}
