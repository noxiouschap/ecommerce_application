import 'dart:convert';
import 'dart:developer';

import 'package:ecommerce_application/provider/cartprovider.dart';
import 'package:ecommerce_application/models/usermodel.dart';
import 'package:ecommerce_application/screens/homepage.dart';
import 'package:ecommerce_application/webservices/webservices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CheckoutPage extends StatefulWidget {
  final List<CartProduct> cart;

  const CheckoutPage({Key? key, required this.cart}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedValue = 1;
  @override
  void initState() {
    super.initState();

    _loadUsername();
  }

  String? username;

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username');
    });
    log("isloggedin = " + username.toString());
  }

  orderPlace(
    List<CartProduct> cart,
    String amount,
    String paymentmethod,
    String date,
    String name,
    String address,
    String phone,
  ) async {
    try {
      String jsondata = jsonEncode(cart);
      log('jsondata =$jsondata');

      final vm = Provider.of<Cart>(context, listen: false);

      final response = await http.post(
          Uri.parse(Webservice.mainurl + "order.php"
              // Webservice.mainurl1 + "order.jsp"
              ),
          body: {
            "username": username,
            "amount": amount,
            "paymentmethod": paymentmethod,
            "date": date,
            "quantity": vm.count.toString(),
            "cart": jsondata,
            'name': name,
            "address": address,
            "phone": phone,
          });

      if (response.statusCode == 200) {
        log(response.body);
        if (response.body.contains("Success")) {
          vm.clearCart();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            content: Text("YOUR ORDER SUCCESSFULLY COMPLETED",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                )),
          ));
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ));
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  String? name, address, phone;
  String? paymentmethod = "Cash on delivery";

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "CheckOut",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<UserModel?>(
                future: Webservice().fetchUser(username.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    name = snapshot.data!.name;
                    phone = snapshot.data!.phone;
                    // phone = snapshot.data!.phone ?? '';

                    address = snapshot.data!.address;
                    return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Name : ",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(name.toString())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Phone : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  Text(phone.toString())
                                  // Text(phone?.toString() ?? 'N/A')
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Address : ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    // color: Colors.amber,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      address.toString(),
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ));
                  }
                  return const CircularProgressIndicator();
                }),
          ),
          const SizedBox(
            height: 10,
          ),
          RadioListTile(
            activeColor: Colors.blue.shade900,
            value: 1,
            groupValue: selectedValue,
            onChanged: (int? value) {
              setState(() {
                selectedValue = value!;
                paymentmethod = 'Cash on delivery';
              });
            },
            title: const Text(
              'Cash On Delivery',
              style: TextStyle(fontFamily: "muli"),
            ),
            subtitle: const Text(
              'Pay Cash At Home',
              style: TextStyle(fontFamily: "muli"),
            ),
          ),
          RadioListTile(
            activeColor: Colors.blue.shade900,
            value: 2,
            groupValue: selectedValue,
            onChanged: (int? value) {
              setState(() {
                selectedValue = value!;
                paymentmethod = 'Online';
              });
            },
            title: const Text(
              'Pay Now',
            ),
            subtitle: const Text(
              'Online Payment',
            ),
          ),
        ],
      )),
      bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              String datetime = DateTime.now().toString();

              log(datetime.toString());
              // orderPlace(cart, amount, paymentmethod, date, name, address, phone)
              orderPlace(widget.cart, vm.totalPrice.toString(), paymentmethod!,
                  datetime, name!, address!, phone!);
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueAccent),
              child: const Center(
                child: Text(
                  "Checkout",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          )),
    );
  }
}
