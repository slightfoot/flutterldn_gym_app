import 'package:flutter/material.dart';
import 'package:gymapp/app/theme.dart';
import 'package:gymapp/mock/mock.dart';
import 'package:gymapp/model/workout.dart';
import 'package:gymapp/pages/workout_details.dart';

class WorkoutListPage extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(
      builder: (context) => WorkoutListPage(),
    );
  }

  @override
  _WorkoutListPageState createState() => _WorkoutListPageState();
}

class _WorkoutListPageState extends State<WorkoutListPage> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<EdgeInsetsGeometry> _padding;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(seconds: 1), vsync: this);

    _padding = EdgeInsetsGeometryTween(
      begin: EdgeInsets.symmetric(vertical: 128.0),
      end: EdgeInsets.symmetric(vertical: 0.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.decelerate),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ModalRoute.of(context).animation.addStatusListener(_onRouteAnimationChanged);
  }

  @override
  void reassemble() {
    super.reassemble();
    _controller?.forward(from: 0.0);
  }

  void _onRouteAnimationChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    var children = <Widget>[
      _WorkoutsHeader(),
    ];

    children.addAll(mockWorkouts.map<Widget>(
      (workout) => AnimatedBuilder(
            animation: _padding,
            builder: (BuildContext context, Widget child) {
              return Opacity(
                opacity: _controller.value,
                child: Padding(
                  padding: _padding.value,
                  child: child,
                ),
              );
            },
            child: _WorkoutsCard(
              workout: workout,
              onTap: () => _onTapWorkout(workout),
            ),
          ),
    ));

    return SingleChildScrollView(
      padding: mediaQuery.padding,
      child: Column(
        children: children,
      ),
    );
  }

  void _onTapWorkout(Workout workout) {
    Navigator.of(context).push(
      WorkoutDetailPage.route(workout),
    );
  }
}

class _WorkoutsCard extends StatelessWidget {
  final Workout workout;
  final VoidCallback onTap;

  const _WorkoutsCard({
    Key key,
    @required this.workout,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: AspectRatio(
        aspectRatio: 2.2,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                image: DecorationImage(
                  image: AssetImage(workout.assetImage),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.7,
              heightFactor: 1.0,
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Spacer(),
                    Text(
                      'Today',
                      style: TextStyle(
                        color: theme.accentColor,
                        fontSize: 12.0,
                      ),
                    ),
                    Text(
                      'Evening with cardio session',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              child: Material(
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: this.onTap,
                  child: SizedBox.expand(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutsHeader extends StatelessWidget {
  const _WorkoutsHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '+ ADD NEW SESSION',
                  style: const TextStyle(
                    color: AppTheme.greyColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'My workouts',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32.0,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/iiro_profile.png'),
            ),
          ),
        ],
      ),
    );
  }
}
