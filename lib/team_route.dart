import 'package:flutter/material.dart';
import 'dart:async';

import 'team_tile.dart';
import 'team.dart';
import 'api.dart';

class TeamRoute extends StatefulWidget {
  @override
  State createState() => _TeamRouteState();
}

class _TeamRouteState extends State<TeamRoute> {
  final _leagues = [
    "English Premier League",
    "Italian Serie A",
    "German Bundesliga",
    "Spanish La Liga"
  ];
  final _teams = <Team>[];
  var _currentLeague = "English Premier League";
  var _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_teams.isEmpty) {
      _retrieveTeams();
    }
  }

  Future _retrieveTeams() async {
    _isLoading = true;
    final api = Api();
    final jsonTeams = await api.getTeams(_currentLeague);

    if (jsonTeams == null) {
      return;
    }

    final teams = jsonTeams.map((team) => Team.fromJson(team)).toList();

    setState(() {
      _isLoading = false;
      _teams.clear();
      _teams.addAll(teams);
    });
  }

  void _onTeamTap(Team team) {
    final snackbar = SnackBar(content: Text("You chose ${team.name}"));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  List<DropdownMenuItem> _buildLeagueDropdownItems() {
    var dropdownItems = <DropdownMenuItem>[];
    for (var league in _leagues) {
      dropdownItems.add(
        DropdownMenuItem(
            value: league,
            child: Container(
                child: Text(
              league,
              softWrap: true,
            ))),
      );
    }

    return dropdownItems;
  }

  Widget _buildLeagueDropdown() {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton(
          value: _currentLeague,
          items: _buildLeagueDropdownItems(),
          onChanged: (value) {
            setState(() {
              _currentLeague = value;
              _retrieveTeams();
            });
          },
          style: Theme.of(context).textTheme.title,
        ),
      ),
    );
  }

  Widget _buildTeamList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TeamTile(
          team: _teams[index],
          onTap: _onTeamTap,
        );
      },
      itemCount: _teams.length,
    );
  }

  Widget _checkIfLoading() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Expanded(
        child: _buildTeamList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Football Teams")),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: _buildLeagueDropdown(),
            ),
          ),
          _checkIfLoading(),
        ],
      ),
    );
  }
}
