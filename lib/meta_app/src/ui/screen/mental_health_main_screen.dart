
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:MetaHelp/meta_app/src/riverpod/bottom_tab_provider.dart';
import 'package:MetaHelp/meta_app/src/ui/screen/mental_wellness_component.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'mental_chat_component.dart';
import 'mental_home_component.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MentalHealthMainScreen());
}
class MentalHealthMainScreen extends StatefulWidget {
  const MentalHealthMainScreen({Key? key}) : super(key: key);

  @override
  _MentalHealthMainScreenState createState() => _MentalHealthMainScreenState();
}

class _MentalHealthMainScreenState extends State<MentalHealthMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer(
          builder: (context, ref, _) {
            final index = ref.watch(mhBottomTabProvider);
            switch (index) {
              case 0:
                return const MentalHomeComponent();
              case 1:
                return const MentalChatComponent();
              case 2:
                return const MentalWellnessComponent();
              case 3:
                return Column(
                  children: [],
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
