import 'package:flutter/material.dart';
import 'package:gafatcash/dashboard/components/sendmoney.dart';
import 'package:gafatcash/startup/controller/routes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:form_validator/form_validator.dart';
import '../../startup/controller/accounts.dart';
import '../components/page3.dart';
import '../utilities/menu.dart';
import '../utilities/home.dart';
import 'calculator.dart';
import 'package:gafatcash/global.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();


}

class _DashboardState extends State<Dashboard> {

  int currentPageIndex = 0;
  late List datalist;
  String? email ="";
  @override
  void initState() {
    FirebaseAccounts().checklogin(context);
   // email= FirebaseAccounts().auth.currentUser!.email;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Consumer<FirebaseAccounts>(
      builder: (BuildContext context, FirebaseAccounts value, Widget? child) {


       return ProgressHUD(
          barrierColor: Colors.black26,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxWidth: 800
              ),
              child: Scaffold(
                backgroundColor: Global.backgroundColor,
                appBar: AppBar(
                  elevation: 1,
                  centerTitle: true,
                  shadowColor: Colors.white54,
                  backgroundColor: Global.backgroundColor,
                  title: const Text(
                    "Gafat Cash ",
                    style: TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                  actions: [
                    PopupMenuButton(
                      itemBuilder: (ctx) => [
                        Menus.buildPopupMenuItem('${value.auth.currentUser!.displayName}', Icons.person, context),
                        Menus.buildPopupMenuItem('Logout', Icons.exit_to_app, context),
                      ],
                    )
                  ],
                ),
                bottomNavigationBar: Theme(
                  data: ThemeData.dark(),
                  child: NavigationBar(
                    elevation: 10,
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
                          color: Global.gradient2,
                        ),
                        icon: Icon(
                          Icons.home_outlined,
                          color: Global.gradient3,
                        ),
                        label: 'Home',
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.monetization_on,
                          color: Global.gradient3,
                        ),
                        label: 'Send Money',
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.my_library_books,
                          color: Global.gradient3,
                        ),
                        label: 'Records',
                      ),
                      NavigationDestination(
                        icon: Icon(
                          Icons.info,
                          color: Global.gradient3,
                        ),
                        label: 'App Info',
                      ),
                    ],
                  ),
                ),
                body: Consumer<FirebaseAccounts>(

                  builder: (context, data2, child) {

                    return <Widget>[
                      Center(
                        child: ConstrainedBox(
                            constraints: const BoxConstraints(
                                maxWidth:900
                            ),
                            child: Home()
                        ),
                      ),
                      FormPage(),
                      //const Center(child: Text("Send Money",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30))),
                      //   Calculator(),
                      Container(
                        alignment: Alignment.center,
                        child:  Page3(),
                      ),
                      Container(
                          alignment: Alignment.center,
                          child: const Text("How the App works...",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),) //Sell(),
                      ),
                    ][currentPageIndex];
                  },
                ),
              ),
            ),
          ),
        );

      },
    );

  }

}
