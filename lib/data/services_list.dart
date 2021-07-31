import 'package:csc4360/data/service.dart';

final List<Service> servicesList = [

  Service(
    id: 'reddit',
    displayName: 'Reddit',
    uriList: <Uri>[
      Uri.parse('https://www.reddit.com/'),
      Uri.parse('https://m.reddit.com/'),
    ],
  ),

  Service(
    id: 'instagram',
    displayName: 'Instagram',
    uriList: <Uri>[
      Uri.parse('https://www.instagram.com/'),
    ],
  ),

  Service(
    id: 'twitter',
    displayName: 'Twitter',
    uriList: <Uri>[
      Uri.parse('https://twitter.com/'),
      Uri.parse('https://pbs.twimg.com/'),
    ],
  ),

  Service(
    id: 'facebook',
    displayName: 'Facebook',
    uriList: <Uri>[
      Uri.parse('https://www.facebook.com/'),
    ],
  ),

  Service(
    id: 'discord',
    displayName: 'Discord',
    uriList: <Uri>[
      Uri.parse('https://discord.com/'),
      Uri.parse('https://cdn.discordapp.com/embed/avatars/0.png'),
    ],
  ),

];

final Map<String, Service> servicesMap = Map.fromIterable(
  servicesList,
  key: (e) => e.id,
  value: (e) => e,
);