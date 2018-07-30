import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'team.dart';

const _rowHeight = 72.0;
final _borderRadius = BorderRadius.circular(5.0);

class TeamTile extends StatelessWidget {
  final Team team;
  final ValueChanged<Team> onTap;

  const TeamTile({Key key, @required this.team, @required this.onTap})
      : assert(team != null),
        assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: Colors.lime,
          splashColor: Colors.green,
          onTap: () => onTap(team),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Image.network(
                    team.imageURL,
                    fit: BoxFit.contain,
                    height: 48.0,
                    width: 48.0,
                  ),
                ),
                Center(
                  child: Text(
                    team.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
