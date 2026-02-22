import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const LoginPage());
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isLoading = false;

  Future<void> login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      await Future.delayed(const Duration(seconds: 1));

      const validEmail = "mark@gmail.com";
      const validPassword = "markpogi123";

      final ok =
          _emailController.text == validEmail &&
          _passwordController.text == validPassword;

      setState(() => isLoading = false);

      if (!mounted) return;

      if (ok) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid email or password")),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "LOGIN",
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white12,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter email";
                  }
                  if (!value.contains("@")) return "Enter valid email";
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter password";
                  if (value.length < 6) return "Minimum 6 characters";
                  return null;
                },
              ),

              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : login,
                  child: isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    Center(child: Text('Home Screen')),
    Center(child: Text('Search Screen')),
    Center(child: Text('Profile Screen')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Welcome Back, Mark Mallari",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 18
              ),
            ),
            SizedBox(height: 2),
            Text(
              "We're happy to see you again!",
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 12,
                color: Colors.grey
              ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2)
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage("https://od2-image-api.abs-cbn.com/prod/editorImage/17275087428851716362836028IMG_3967.webp"),
                backgroundColor: Colors.transparent,
              ),
            ),
          
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
