import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:km_test/features/second_screen/presentation/page/page_two.dart';
import 'package:km_test/features/third_screen/presentation/bloc/users_bloc.dart';
import 'package:km_test/features/third_screen/presentation/widgets/list_item.dart';

import '../../../../core/theme/base_colors.dart';

class PageThree extends StatefulWidget {
  final String username;

  const PageThree({Key? key, required this.username}) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  final ScrollController _scrollController = ScrollController();
  bool _isLimit = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setupScrollController(context) {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          if (!_isLimit) {
            _loadMoreData();
          }
        }
      }
    });
  }

  void _loadMoreData() {
    final usersBloc = context.read<UsersBloc>();
    usersBloc.add(UsersLoadMoreDataEvent());
  }

  Future<void> _refreshData() async {
    final usersBloc = context.read<UsersBloc>();
    usersBloc.add(UsersRefreshDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    _setupScrollController(context);
    return Scaffold(
        appBar: AppBar(
            title: const Text("Third Screen"),
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
        body: BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            if (state is UsersInitialState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UsersLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UsersLoadedState) {
              _isLimit = state.isLimit;
              return RefreshIndicator(
                onRefresh: _refreshData,
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (context, index) {
                    if (index < state.users.length) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: ListItem(
                          userModel: state.users[index],
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageTwo(
                                          username: widget.username,
                                          selectedUsername:
                                              "${state.users[index].firstName} ${state.users[index].lastName}",
                                        )));
                          },
                        ),
                      );
                    } else {
                      Timer(const Duration(milliseconds: 30), () {
                        _scrollController
                            .jumpTo(_scrollController.position.maxScrollExtent);
                      });
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                  itemCount: state.users.length,
                ),
              );
            } else if (state is UsersErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text("Unknown Error"),
              );
            }
          },
        ));
  }
}
