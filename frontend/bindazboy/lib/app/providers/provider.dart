import 'package:bindazboy/core/notifiers/audiobook.notifer.dart';
import 'package:bindazboy/core/notifiers/authentication.notifier.dart';
import 'package:bindazboy/core/notifiers/blogs.notifier.dart';
import 'package:bindazboy/core/notifiers/bookmark.notifer.dart';
import 'package:bindazboy/core/notifiers/cache.notifier.dart';
import 'package:bindazboy/core/notifiers/catergoryblogs.notifer.dart';
import 'package:bindazboy/core/notifiers/forgotpassword.notifier.dart';
import 'package:bindazboy/core/notifiers/utility.notifer.dart';

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => AuthenticationNotifer()),
  ChangeNotifierProvider(create: (_) => BlogNotifer()),
  ChangeNotifierProvider(create: (_) => ForgotPasswordNotifer()),
  ChangeNotifierProvider(create: (_) => CacheNotifier()),
  ChangeNotifierProvider(create: (_) => BookmarkNotifier()),
  ChangeNotifierProvider(create: (_) => CatergoryBlogNotifer()),
  ChangeNotifierProvider(create: (_) => UtilityNotifier()),
  ChangeNotifierProvider(create: (_) => AudioBookNotifer()),
];
