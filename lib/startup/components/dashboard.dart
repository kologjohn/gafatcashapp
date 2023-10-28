import 'package:flutter/material.dart';
import 'package:gafatcash/dashboard/components/sell.dart';
import 'package:provider/provider.dart';
import '../../dashboard/components/calculator.dart';
import '../../dashboard/components/page3.dart';
import '../../dashboard/utilities/home.dart';
import '../../dashboard/utilities/menu.dart';
import '../controller/accounts.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_validator/form_validator.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});


  @override
  State<Dashboard> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<Dashboard> {
  int currentPageIndex = 0;


  late List datalist;

  //final _salesform=GlobalKey<FormState>();
  final GlobalKey<FormState> _salesform = GlobalKey<FormState>();




  @override
  void initState() {
    super.initState();
    //sessioninnitil();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      barrierColor: Colors.black26,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 800
          ),
          child: Scaffold(
            backgroundColor:Colors.black ,
            appBar: AppBar(
              elevation: 1,
              centerTitle: true,
              shadowColor: Colors.white54,
              backgroundColor: Colors.black,
              title: const Text(
                "Gold Calculator ",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
              actions: [
                PopupMenuButton(
                  itemBuilder: (ctx) => [
                    Menus.buildPopupMenuItem('Profile', Icons.person, context),
                    Menus.buildPopupMenuItem('Logout', Icons.exit_to_app, context),
                  ],
                )
              ],
            ),
            bottomNavigationBar: Theme(
              data: ThemeData.dark(),
              child: NavigationBar(
                elevation: 10,
                backgroundColor: const Color.fromRGBO(0, 10, 14, 1),
                shadowColor: Colors.white,
                surfaceTintColor: Colors.white,
                onDestinationSelected: (int index) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
                indicatorColor: Colors.white12,
                selectedIndex: currentPageIndex,
                destinations: const <Widget>[
                  NavigationDestination(
                    selectedIcon: Icon(
                      Icons.home,
                      color: Colors.amber,

                    ),
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.orangeAccent,
                    ),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.calculate,
                      color: Colors.amber,
                    ),
                    label: 'Sell',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.calculate,
                      color: Colors.amber,
                    ),
                    label: 'Buy',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.storage,
                      color: Colors.amber,
                    ),
                    label: 'Report',
                  ),
                ],
              ),
            ),
            body: Consumer<FirebaseAccounts>(
              builder: (context, data2, child) {
                return <Widget>[
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth:900
                      ),
                        child: Text("Home Data")//Home()
                    ),
                  ),
                  Calculator(),
                  Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Page3(),
                  ),
                  Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Sell(),
                  ),
                ][currentPageIndex];
              },
            ),
          ),
        ),
      ),
    );

  }

}
