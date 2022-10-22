import 'package:chatbox/screens/home_screen.dart';
import 'package:flutter/material.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        scrollDirection:Axis.vertical ,
        children:[ Container(
          width: MediaQuery.of(context).size.width-50,
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Icon(Icons.person_outline, color: Colors.grey[400], size: 140,),
              _Header(context),
              const SizedBox(height: 60,),
              _inputField(context),
              
              _forgetPassword(context),
              _signup(context),
            ],
          ),
        ),
       ]) ,
    );
  }
  _Header(context){
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        const Text('Welcome to our platform chat ',
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          ),
        ),
        const Text('Enter your crendatial to login'),

      ],
    );
  }
  _inputField(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch ,
      children:  [
        TextField(
          decoration: InputDecoration(
            hintText: 'Username',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,),
            fillColor:Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 10,),
        TextField(
          decoration: InputDecoration(
            hintText: 'Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,),
            fillColor:Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 10,),
        ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context){
              return  HomeScreen();
            }));
        }, child: const Text(
          'Login', style: TextStyle(
            fontSize: 20,),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16)
          )
          )

      ],
    );
  }
  _forgetPassword(context){
    return TextButton(onPressed: (){} , child: Text('Forget password ?'));
  }
  _signup(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        Text('Don\'t have an account ?'),
        TextButton(onPressed: (){} , child: Text('Sign up')),
      ],
    );
  }


}