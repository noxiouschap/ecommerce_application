import 'package:ecommerce_application/webservices/loginpage.dart';
import 'package:ecommerce_application/provider/cartprovider.dart';
import 'package:ecommerce_application/screens/cartpage.dart';
import 'package:ecommerce_application/screens/homepage.dart';
import 'package:ecommerce_application/screens/orderdetailspage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 50,
            ),
            const Align(
                alignment: Alignment.center,
                child: Text(
                  "E-COMMERCE",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text(
                'Home',
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: badges.Badge(
                  showBadge:
                      //  true,
                      context.read<Cart>().getItems.isEmpty ? false : true,
                  badgeStyle:
                      const badges.BadgeStyle(badgeColor: Colors.blueAccent),
                  badgeContent: Text(
                    context.watch<Cart>().getItems.length.toString(),
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.grey,
                    // size: 15,
                  )),
              //const Icon(Icons.shopping_cart),
              title: const Text(
                'Cart page',
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text(
                'Order Details',
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () {
                // OrderdetailsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OrderdetailsPage()),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.power_settings_new_rounded,
                  color: Colors.red.shade900),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 15.0),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("isLoggedIn", false);
                Navigator.push(
                  // ignore: use_build_context_synchronously
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
