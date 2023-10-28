import 'package:flutter/material.dart';
import 'package:gafatcash/dashboard/components/sell.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_validator/form_validator.dart';
import '../../startup/controller/accounts.dart';
import '../components/page3.dart';
import '../utilities/menu.dart';
import '../utilities/home.dart';
import 'calculator.dart';

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
                "Gafat Cash ",
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
                    label: 'Send Money',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.calculate,
                      color: Colors.amber,
                    ),
                    label: 'Pending',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.storage,
                      color: Colors.amber,
                    ),
                    label: 'Completed',
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
                        child: const Text("Home Statistics",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30))//Home()
                    ),
                  ),
                  const Center(child: Text("Send Money",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30))),
               //   Calculator(),
                  Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text("Pending transaction here",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30))// Page3(),
                  ),
                  Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text("completed Transactions",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),) //Sell(),
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
