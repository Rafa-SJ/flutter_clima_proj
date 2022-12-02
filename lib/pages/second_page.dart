import 'package:flutter/material.dart';

///SECOND PAGE, SHOW DETAIL FOR SOME WEATHER LOCATION

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String ciudadTarget = "sa";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenTopPadding = MediaQuery.of(context).padding.top;
    final double leftPadding = 15;
    final double rightPadding = 10;

    return Scaffold(
        backgroundColor: const Color(0xff232535),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          // title: const Text("First Page"),
          flexibleSpace: Container(
            height: kToolbarHeight + screenTopPadding,
            color: Colors.red,
            padding: EdgeInsets.fromLTRB(
              50,
              screenTopPadding,
              rightPadding,
              0,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: screenWidth * 0.6,
                        child: TextFormField(
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/second');
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: leftPadding),
          child: ciudadTarget == ""
              ? ListaBuscadorCiudad()
              : const DetalleCiudad(),
        ));
  }
}

class DetalleCiudad extends StatelessWidget {
  const DetalleCiudad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Text("Clima ACTUAL"),
            ),
          ),
          Text("Proximos 3 dias"),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Sunday",
                      style: TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          "28º",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "28º",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.cloudy_snowing,
                      size: 25,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ListaBuscadorCiudad extends StatelessWidget {
  const ListaBuscadorCiudad({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        itemCount: 100,
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 2,
            height: 4,
            color: Colors.white.withOpacity(0.2),
          );
        },
        itemBuilder: (context, index) {
          return Card(
            color: Colors.transparent,
            elevation: 0,
            child: const Text(
              "Santiago",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
