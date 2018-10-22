import 'package:flutter/material.dart';
import 'package:gymapp/app/icons.dart';
import 'package:gymapp/model/workout.dart';
import 'package:gymapp/widgets/routes.dart';
import 'package:gymapp/widgets/horz_list.dart';

class WorkoutDetailPage extends StatefulWidget {
  static Route<dynamic> route(Workout workout) {
    return MaterialPageRoute(
      //duration: const Duration(seconds: 2),
      builder: (context) => WorkoutDetailPage(
            workout: workout,
          ),
    );
  }

  const WorkoutDetailPage({
    Key key,
    @required this.workout,
  }) : super(key: key);

  final Workout workout;

  @override
  _WorkoutDetailPageState createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: <Widget>[
        _WorkoutHeader(
          workout: widget.workout,
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(top: constraints.maxWidth * 0.9),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: theme.backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    ),
                    child: Container(
                      height: constraints.maxHeight,
                      child: Column(
                        children: <Widget>[
                          HorizontalFeaturedItems(
                            viewportFraction: 1.0 / 2.5,
                            itemCount: 3,
                            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                            itemBuilder: (BuildContext context, int index) {
                              return Card();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        SafeArea(
          child: _BackButton(),
        ),
      ],
    );
  }
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 32.0, 32.0),
        child: InkResponse(
          onTap: () => Navigator.of(context).pop(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                AppIcons.chevron_left,
                color: Colors.white,
                size: 20.0,
              ),
              Text(
                'Back',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutHeader extends StatelessWidget {
  const _WorkoutHeader({
    Key key,
    @required this.workout,
  }) : super(key: key);

  final Workout workout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(workout.assetImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: SafeArea(
          child: FractionallySizedBox(
            widthFactor: 0.7,
            heightFactor: 0.85,
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
        ),
      ),
    );
  }
}
