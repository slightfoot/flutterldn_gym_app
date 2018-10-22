import 'package:flutter/material.dart';
import 'package:gymapp/app/icons.dart';
import 'package:gymapp/app/theme.dart';
import 'package:gymapp/pages/blank.dart';
import 'package:gymapp/pages/workout_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
        child: Navigator(
          key: _navigatorKey,
          onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
              builder: (context) => BlankPage(),
            );
          },
        ),
      ),
      bottomNavigationBar: _NavBar(
        onItemSelected: _onNavItemSelected,
        items: [
          _NavItem(
            icon: AppIcons.coaches,
            label: 'Coaches',
          ),
          _NavItem(
            icon: AppIcons.challenges,
            label: 'Challenges',
          ),
          _NavItem(
            icon: AppIcons.workouts,
            label: 'Workouts',
          ),
          _NavItem(
            icon: AppIcons.profile,
            label: 'Profile',
          ),
          _NavItem(
            icon: AppIcons.health,
            label: 'Health',
          ),
        ],
      ),
    );
  }

  void _onNavItemSelected(int index) {
    Route<dynamic> route;
    if (index == 2) {
      route = WorkoutListPage.route();
    } else {
      route = BlankPage.route();
    }
    _navigatorKey.currentState.pushReplacement(route);
  }
}

class _NavBar extends StatefulWidget {
  const _NavBar({
    Key key,
    @required this.items,
    this.onItemSelected,
  }) : super(key: key);

  final List<_NavItem> items;
  final ValueChanged<int> onItemSelected;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<_NavBar> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BottomAppBar(
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: AppTheme.iconColor),
        child: IconTheme(
          data: theme.primaryIconTheme.copyWith(color: AppTheme.iconColor),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: List<Widget>.generate(
                  widget.items.length,
                  (index) => _buildNavItem(context, index),
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index) {
    final item = widget.items[index];

    Widget child = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(item.icon),
        SizedBox(height: 4.0),
        Text(
          item.label,
          textScaleFactor: 0.8,
        ),
      ],
    );

    if (index == _selected) {
      final theme = Theme.of(context);

      child = DefaultTextStyle.merge(
        style: TextStyle(color: theme.accentColor),
        child: IconTheme.merge(
          data: IconThemeData(color: theme.accentColor),
          child: child,
        ),
      );
    }

    return Expanded(
      child: InkResponse(
        onTap: widget.onItemSelected != null ? () => _onItemSelected(index) : null,
        child: child,
      ),
    );
  }

  void _onItemSelected(int index) {
    setState(() => _selected = index);
    widget.onItemSelected(index);
  }
}

class _NavItem {
  const _NavItem({
    @required this.icon,
    @required this.label,
  });

  final IconData icon;
  final String label;
}
