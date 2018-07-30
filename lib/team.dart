import 'package:meta/meta.dart';

class Team {
  final String imageURL;
  final String name;

  const Team({@required this.imageURL, @required this.name})
      : assert(name != null),
        assert(imageURL != null);

  Team.fromJson(Map jsonMap)
      : name = jsonMap["strTeam"],
        imageURL = jsonMap["strTeamBadge"],
        assert(name != null),
        assert(imageURL != null);
}
