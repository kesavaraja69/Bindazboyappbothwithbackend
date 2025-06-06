import 'package:adminbindazboyapp/core/notifiers/authentication.notifer.dart';
import 'package:adminbindazboyapp/core/notifiers/blog.notifier.dart';
import 'package:adminbindazboyapp/core/notifiers/cache.notifier.dart';
import 'package:adminbindazboyapp/core/notifiers/category.notifier.dart';
import 'package:adminbindazboyapp/core/notifiers/notification.notifier.dart';
import 'package:adminbindazboyapp/core/notifiers/utility.notifer.dart';
import 'package:adminbindazboyapp/core/notifiers/zoom.notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AuthenticationNotifier()),
  ChangeNotifierProvider(create: (_) => CacheNotifer()),
  ChangeNotifierProvider(create: (_) => UtilityNotifer()),
  ChangeNotifierProvider(create: (_) => CategoryNotifer()),
  ChangeNotifierProvider(create: (_) => BlogNotifer()),
  ChangeNotifierProvider(create: (_) => NotificationNotifiter()),
  ChangeNotifierProvider(create: (_) => ZoomNoitifer()),
];
