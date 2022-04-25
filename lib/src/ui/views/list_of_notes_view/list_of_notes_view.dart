import 'package:canton_design_system/canton_design_system.dart';
import 'package:elisha/src/ui/views/list_of_notes_view/list_of_notes_header_view.dart';
import 'package:flutter/material.dart';

class ListOfNotesPage extends StatefulWidget {
  const ListOfNotesPage({Key? key}) : super(key: key);

  @override
  _ListOfNotesPageState createState() => _ListOfNotesPageState();
}

class _ListOfNotesPageState extends State<ListOfNotesPage> {
  final List titles = ['Note1', 'Note2', 'Note3', 'Note4', 'Note5'];
  final List days = ['Day1', 'Day2', 'Day3', 'Day4', 'Day5'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey[400],
          child: const Icon(Icons.add, color: Colors.black),
          onPressed: () {},
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
              children: [
                const ListofNotesHeaderView(),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      //Color.fromARGB(50, 255, 255, 255),
                      borderRadius: const BorderRadius.all(Radius.circular(30.0))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                          child: TextField(
                            decoration: InputDecoration(
                              fillColor: Colors.grey[800],
                              border: InputBorder.none,
                              hintText: 'Search note',
                              hintStyle: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.mic, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                            color: Colors.white10)
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                    const SizedBox(height: 5),
                                    const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                  ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white10)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("A new creation", style: Theme.of(context).textTheme.headline4),
                                      const SizedBox(height: 5),
                                      const Text("I learnt plenty and plenty and plenty other things from the plenty things i read plenty plenty", overflow: TextOverflow.ellipsis,)
                                    ]
                                ),
                              ),
                              const SizedBox(width: 20,),
                              const Text("Sept 7")
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
        ),
      ),
    );
  }
}
