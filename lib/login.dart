import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ujikom_firdan/home.dart';
import 'package:ujikom_firdan/main.dart';
import 'package:ujikom_firdan/services/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool loading = false;
  login() async {
    setState(() {
      loading = true;
    });
    var dd = await getApiMethod(apis: 'acc.json');
    if (dd != null) {
      if (dd['username'].toString().toLowerCase() ==
              username.text.toLowerCase() &&
          dd['password'].toString().toLowerCase() ==
              password.text.toLowerCase()) {
        Navigator.pushReplacement(GlobalVariable.navState.currentState!.context,
            CupertinoPageRoute(builder: (context) => const HomePage()));
        setState(() {
          loading = false;
        });
      } else if (dd['username'].toString().toLowerCase() !=
          username.text.toLowerCase()) {
        showSnackBar('Username Tidak Sesuai!', Colors.red);
        setState(() {
          loading = false;
        });
      } else if (dd['password'].toString().toLowerCase() !=
          password.text.toLowerCase()) {
        showSnackBar('Password Tidak Sesuai!', Colors.red);
        setState(() {
          loading = false;
        });
      } else {
        showSnackBar('Username & Password Tidak Sesuai!', Colors.red);
        setState(() {
          loading = false;
        });
      }
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(position_data?.latitude);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                Image.asset(
                  'assets/images/logo_login.png',
                  width: 250,
                  // height: 120,
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Uji Kompetensi Firdan',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: username,
                  decoration: const InputDecoration(
                      label: Text('Username',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black))),
                ),
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: const InputDecoration(
                      label: Text('Password',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black))),
                ),
                const SizedBox(
                  height: 16,
                ),
                loading
                    ? const LinearProgressIndicator()
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: TextButton(
                            onPressed: () {
                              if (username.text.isNotEmpty &&
                                  password.text.isNotEmpty) {
                                login();
                              }
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.blue),
                            child: const Text('Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18))),
                      ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: const Text(
                    'Tidak memiliki akun ?',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showSnackBar(String label, Color color) {
    // ScaffoldMessenger.of(GlobalKey().currentState!.context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      content: Text(label),
      backgroundColor: color,
    );

    // Find the ScaffoldMessenger in the widget tree
    // and use it to show a SnackBar.
    ScaffoldMessenger.of(GlobalVariable.navState.currentState!.context)
        .showSnackBar(snackBar);
  }
}
