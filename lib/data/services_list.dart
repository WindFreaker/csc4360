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
    uriList: <Uri>[],
  ),

  Service(
    id: 'twitter',
    displayName: 'Twitter',
    uriList: <Uri>[],
  ),

  Service(
    id: 'facebook',
    displayName: 'Facebook',
    uriList: <Uri>[],
  ),

  Service(
    id: 'discord',
    displayName: 'Discord',
    uriList: <Uri>[
      Uri.parse('https://discord.com/'),
      Uri.parse('https://cdn.discordapp.com/'),
    ],
  ),

];

final Map<String, Service> servicesMap = Map.fromIterable(
  servicesList,
  key: (e) => e.id,
  value: (e) => e,
);