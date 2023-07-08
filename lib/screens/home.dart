// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_sample/bloc/homepage/homepage_bloc.dart';
import 'package:hive_sample/components/displaylist.dart';
import 'package:hive_sample/screens/favorites.dart';
import 'package:hive_sample/screens/search.dart';
import 'package:hive_sample/components/shimmerloading.dart';
import 'package:hive_sample/screens/wishlist.dart';

import '../service/model.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<HomepageBloc>().add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
        child: Drawer(
            child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlueAccent),
              child: Text("CookOo",
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: Icon(Icons.favorite_border),
              title: Text('Favorites'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Favorites()));
              },
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted_add),
              title: Text('Wishlist'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WishList()));
              },
            ),
          ],
        )),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.restaurant_menu),
          SizedBox(
            width: 5,
          ),
          Text("CookOo"),
        ]),
      ),
      body: BlocBuilder<HomepageBloc, HomepageState>(builder: (context, state) {
        if (state is HomepageLoading) {
          return ShimmerLoading();
        }
        if (state is HomepageFailed) {
          return Center(child: Text(state.error));
        }
        if (state is HomepageSuccess) {
          List<Model> suggestionList = state.dataFetched;
          return DisplayList(list: suggestionList);
        } else {
          return (Center(child: Text("Loading....")));
        }
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Search()));
        },
        child: const Icon(Icons.search),
      ),
    );
  }
}
