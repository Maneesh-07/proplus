import 'package:flutter/material.dart';
import 'package:proplus/services/api_call.dart';
import 'package:proplus/views/home/widgets/main_page.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 370,
              width: 310,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    "assets/images/3696296.png",
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: emailController,
                              decoration: InputDecoration(
                                  labelText: "E-Mail",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                  suffixIcon: const Icon(Icons.mail_sharp)),
                              // validator: (val) {
                              //   if(val.length==0) {
                              //     return "Email cannot be empty";
                              //   }else{
                              //     return null;
                              //   }
                              // },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                  labelText: "Password",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                  suffixIcon: const Icon(Icons.visibility)),
                              // validator: (val) {
                              //   if(val.length==0) {
                              //     return "Email cannot be empty";
                              //   }else{
                              //     return null;
                              //   }
                              // },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                ApiClass().login(emailController.text,
                                    passwordController.text);
                                Future.delayed(
                                  const Duration(seconds: 3),
                                  () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                               ScreenMainPage(),
                                        ));
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(500, 60),
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
