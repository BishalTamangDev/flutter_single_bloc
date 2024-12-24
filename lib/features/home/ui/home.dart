import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:single_bloc/features/home/bloc/home_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        switch (state.runtimeType) {
          case HomeScackbarState:
            if(ScaffoldMessenger.of(context).mounted) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Hello World!"),
              ),
            );
            break;
          default:
            log("Listener activated");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              appBar: AppBar(
                title: const Text("Home"),
                centerTitle: true,
              ),
              body: const Center(
                child: Column(
                  spacing: 16.0,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    Text("Loading home page"),
                  ],
                ),
              ),
            );
          case HomeLoadingSuccessState:
            return Scaffold(
              appBar: AppBar(
                title: const Text("Home"),
                centerTitle: true,
              ),
              body: Center(
                child: Column(
                  spacing: 16.0,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Home page loaded successfully!"),
                    OutlinedButton(
                        onPressed: () {
                          homeBloc.add(HomeSnackbarEvent());
                        },
                        child: const Text("Show Snackbar")),
                  ],
                ),
              ),
            );
          case HomeLoadingFailureState:
            return Scaffold(
              appBar: AppBar(
                title: const Text("Home"),
                centerTitle: true,
              ),
              body: Center(
                child: Column(
                  spacing: 16.0,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        homeBloc.add(HomeInitialEvent());
                      },
                      icon: Icon(Icons.refresh_outlined),
                    ),
                    Text("Couldn't load home page!"),
                  ],
                ),
              ),
            );
          default:
            return Scaffold(
              appBar: AppBar(
                title: const Text("Home"),
                centerTitle: true,
              ),
              body: const Center(
                child: Text("An error occurred!"),
              ),
            );
        }
      },
    );
  }
}
