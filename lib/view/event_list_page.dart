import 'package:flutter/material.dart';
import 'package:gathrr/controller/event_controller.dart';
import 'package:gathrr/model/event_list_model/event_list_model.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({super.key});

  @override
  State<EventListPage> createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  final PostBloc bloc = PostBloc();

  @override
  void initState() {
    bloc.fetchEventList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
      ),
      body: StreamBuilder(
        stream: bloc.posts,
        builder: (context, AsyncSnapshot<List<EventListModel>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].organiserName),
                  subtitle: Text(snapshot.data![index].organiserMaster),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
