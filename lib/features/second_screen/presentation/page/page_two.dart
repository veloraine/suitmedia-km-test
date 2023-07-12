import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:km_test/core/bases/widgets/primary_button.dart';
import 'package:km_test/core/theme/base_colors.dart';

import '../../../third_screen/presentation/bloc/users_bloc.dart';
import '../../../third_screen/presentation/page/page_three.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key, required this.username, this.selectedUsername})
      : super(key: key);
  final String username;
  final String? selectedUsername;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Second Screen"),
            titleTextStyle: const TextStyle(
              fontSize: 18,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w600,
              color: BaseColors.black,
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios,
                  color: BaseColors.accentBlue),
              onPressed: () => Navigator.of(context).pop(),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                color: BaseColors.black,
                height: 0.1,
              ),
            )),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                  color: BaseColors.black,
                ),
              ),
              Text(
                username,
                style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  color: BaseColors.black,
                ),
              ),
              Expanded(
                  child: Center(
                      child: Text(
                selectedUsername ?? "Selected User Name",
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                  color: BaseColors.black,
                ),
              ))),
              SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                      text: "Choose a User",
                      onPressed: () {
                        // go to third screen that uses bloc
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => UsersBloc()
                                        ..add(UsersFetchDataEvent(
                                            page: 1, perPage: 10)),
                                      child: PageThree(
                                        username: username,
                                      ),
                                    )));
                      }))
            ],
          ),
        ));
  }
}
