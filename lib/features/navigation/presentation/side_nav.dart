import 'package:admin_panel/features/authentication/presentation/login/presentation/login.dart';
import 'package:admin_panel/features/navigation/bloc/navigation_bloc.dart';
import 'package:admin_panel/features/user/presentation/user_screen.dart';
import 'package:admin_panel/features/verification/presentation/verification.dart';
import 'package:admin_panel/repository/access_token_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SideNavScreen extends StatelessWidget {
  const SideNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> sideNavs = [
      "Verification",
      "Users",
    ];

    List<Widget> pages = [
      const VerificationPage(),
      const UserScreen(),
    ];
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: Scaffold(
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            late int selectedIndex;
            if (state is NavigationIndex) {
              selectedIndex = (state as NavigationIndex).index;
            } else {
              selectedIndex = 0;
            }
            return Row(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: const BoxDecoration(color: Colors.deepPurple),
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                          ),
                          ...List.generate(
                              sideNavs.length,
                              (index) => GestureDetector(
                                    onTap: () => context
                                        .read<NavigationBloc>()
                                        .add(ChangeIndexEvent(index)),
                                    child: NavItem(
                                      title: sideNavs[index],
                                      isSelected: selectedIndex == index,
                                    ),
                                  )),
                          const Spacer(),
                          ElevatedButton.icon(
                              onPressed: () {
                                AccessTokenRepo().removeAccessToken();
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                  builder: (context) {
                                    return const Login();
                                  },
                                ));
                              },
                              icon: const Icon(Icons.logout),
                              label: const Text("Logout")),
                          const SizedBox(height: 20),

                          ///will add logo here
                        ],
                      ),
                    )),
                Expanded(flex: 4, child: pages[selectedIndex])
              ],
            );
          },
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({super.key, required this.title, this.isSelected = false});
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange : Colors.transparent),
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
