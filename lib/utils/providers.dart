import 'package:flutter_video_call/view_models/auth/display_picsVM.dart';
import 'package:flutter_video_call/view_models/auth/loginVM.dart';
import 'package:flutter_video_call/view_models/auth/registerVM.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => RegisterViewModel()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => ProfileViewModel()),

];
