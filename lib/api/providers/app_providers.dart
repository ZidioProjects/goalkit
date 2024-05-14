import 'package:goalkit/api/providers/login_provider.dart';
import 'package:goalkit/api/providers/signup_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<LoginProvider>(
  create: (context) => LoginProvider(),
  ),
  ChangeNotifierProvider<SignUpProvider>(
    create: (context) => SignUpProvider(),
  )
];