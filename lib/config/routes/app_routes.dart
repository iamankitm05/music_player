enum AppRoutes {
  home(name: 'home', path: '/'),
  settings(name: 'settings', path: '/settings');

  final String name;
  final String path;

  const AppRoutes({required this.name, required this.path});
}
