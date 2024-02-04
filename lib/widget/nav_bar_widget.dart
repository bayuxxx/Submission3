import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:submission2/provider/scheduling_provider.dart';
import 'package:submission2/screen/favorite_screen.dart';
import 'package:submission2/screen/list_screen.dart';
import 'package:submission2/screen/setting_screen.dart';
import 'package:submission2/utils/notification_helper.dart';

class NavBarWidget extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const NavBarWidget({
    Key? key,
    required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  State<NavBarWidget> createState() => _NavBarWidgetState();
}

class _NavBarWidgetState extends State<NavBarWidget> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  @override
  void initState() {
    _notificationHelper.configureSelectNotificationSubject(
      context,
    );
    context.read<SchedulingProvider>().loadIsScheduled();
    super.initState();
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PageProvider(),
      child: Consumer<PageProvider>(
        builder: (context, pageProvider, _) {
          return Scaffold(
            body: PageView(
              key: const PageStorageKey<String>('ListScreen'),
              controller: widget._pageController,
              onPageChanged: (index) {
                context.read<PageProvider>().setCurrentPage(index);
              },
              children: const [
                ListScreen(),
                FavoriteScreen(),
                SettingScreen(),
              ],
            ),
            extendBody: true,
            bottomNavigationBar: RollingBottomBar(
              color: Colors.grey,
              controller: widget._pageController,
              itemColor: Colors.black,
              flat: true,
              useActiveColorByDefault: false,
              items: const [
                RollingBottomBarItem(Icons.home,
                    label: 'Home', activeColor: Colors.white),
                RollingBottomBarItem(Icons.favorite,
                    label: 'Favorite', activeColor: Colors.white),
                RollingBottomBarItem(Icons.settings,
                    label: 'Setting', activeColor: Colors.white),
              ],
              enableIconRotation: true,
              onTap: (index) {
                setState(() {
                  context.read<PageProvider>().setCurrentPage(index);
                  widget._pageController.animateToPage(
                    index,
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOut,
                  );
                });
              },
            ),
          );
        },
      ),
    );
  }
}

class PageProvider extends ChangeNotifier {
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void setCurrentPage(int index) {
    _currentPage = index;
    notifyListeners();
  }
}
