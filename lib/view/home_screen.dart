import 'package:flutter/material.dart';
import 'package:mvvm_provider/data/response/status.dart';
import 'package:mvvm_provider/utils/routes/routes_name.dart';
import 'package:mvvm_provider/utils/utils.dart';
import 'package:mvvm_provider/view_model/home_view_model.dart';
import 'package:mvvm_provider/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeViewViewModel.fetchProductListApi();
  }

  @override
  Widget build(BuildContext context) {

    final userViewModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("home screen"), actions: [
        Center(
          child: GestureDetector(
              onTap: () {
                userViewModel.removeUserData().then((value) {
                  Navigator.pushNamed(context, RoutesName.login);
                  Utils().flushBarErrorMessage("Log out successfully", context);
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: const Text("Logout")),
        ),
      ]),
      body: ChangeNotifierProvider<HomeViewViewModel>(
        child: Consumer<HomeViewViewModel>(
          builder: (context, value, child) {
            switch(value.productList.status)
            {
              case Status.LOADING:
                return const CircularProgressIndicator();
              case Status.ERROR:
                return Text(value.productList.message.toString());
              case Status.COMPLETED:
                return const Text("data aavi gaya");
              case null:
                // TODO: Handle this case.
            }
            return Container();
          },
        ),
        create: (context) => homeViewViewModel,
      ),
    );
  }
}
