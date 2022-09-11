import 'package:bindazboyadminapp/core/notifiers/authentication.notifer.dart';
import 'package:bindazboyadminapp/core/notifiers/blog.notifier.dart';
import 'package:bindazboyadminapp/core/notifiers/cache.notifier.dart';
import 'package:bindazboyadminapp/core/notifiers/category.notifier.dart';
import 'package:bindazboyadminapp/core/notifiers/notification.notifier.dart';
import 'package:bindazboyadminapp/core/notifiers/utility.notifer.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AuthenticationNotifier()),
  ChangeNotifierProvider(create: (_) => CacheNotifer()),
  ChangeNotifierProvider(create: (_) => UtilityNotifer()),
  ChangeNotifierProvider(create: (_) => CategoryNotifer()),
  ChangeNotifierProvider(create: (_) => BlogNotifer()),
  ChangeNotifierProvider(create: (_) => NotificationNotifiter()),
];
