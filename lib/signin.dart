import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_reminder_app/project_constants.dart';
import 'package:news_reminder_app/signup.dart';
import 'package:news_reminder_app/user_model.dart';

import 'blocs/auth_bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        title: loggedInUser.email != "loading..."
            ? Text(loggedInUser.email,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))
            : const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            const SizedBox(height: 12.0),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                } else if (state is AuthSuccess) {
                  return ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ),
                      );
                    },
                    child: const Text('Sign Up 1'),
                  );
                } else {
                  return ElevatedButton(
                    onPressed: () {
                      authBloc.add(SignInEvent(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ));
                    },
                    child: const Text('Sign In'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
