import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/theme/theme.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:client/features/home/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();


  

  final directory = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = directory.path;


  final container = ProviderContainer();

  await container.read(authViewModelProvider.notifier).initSharedPreferences();

  

  final userModel = await container.read(authViewModelProvider.notifier).getData();
  print(userModel);


  runApp( UncontrolledProviderScope(

    container: container,
    
    
    child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final currentUser = ref.watch(currentUserNotifierProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      debugShowCheckedModeBanner: false,
      home: currentUser == null? 
       const SignupPage():
       const HomePage() ,
    );
  }
}

