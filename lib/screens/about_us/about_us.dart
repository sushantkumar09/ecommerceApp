import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
final Uri _url = Uri.parse('https://github.com/sushantkumar09');
class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 50.0,
                left: 20,
                right: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //SizedBox(width: 10.0),
                      Text(
                        'Flex',
                        style: TextStyle(fontSize: 36),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.blue.shade700,
                    thickness: 1.2,
                    endIndent: 30,
                    indent: 30,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.infoCircle,
                                color: Colors.grey.shade900,
                                size: 35,
                              ),
                              SizedBox(
                                width: 30.0,
                              ),
                              Text(
                                'Version v1.0.0',
                                style: TextStyle(fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.blue.shade700,
                          thickness: 1.2,
                          endIndent: 30,
                          indent: 30,
                        ),
                      
                      ],
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(0xFFADD8E6),
                    ),
                  ),
               const    SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.all(10.0),
                    padding: EdgeInsets.all(10.0),

                    child: Column(
                      children: [
                        const Text(
                          'Developers',
                          style: TextStyle(fontSize: 22),
                        ),
                       const  SizedBox(
                          height: 10,
                        ),

                        Divider(
                          color: Colors.blue.shade700,
                          thickness: 1.2,
                          endIndent: 30,
                          indent: 30,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(
                                FontAwesomeIcons.github,
                              ),
                              const Text('Sushant Kumar',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              InkWell(
                                child: const Text(
                                  'GITHUB',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onTap: _launchUrl,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.blue.shade700,
                          thickness: 1.2,
                          endIndent: 30,
                          indent: 30,
                        ),
                        SizedBox(
                          height: 10,
                        ),


                      ],
                    ),
                    //color: Color(0xFF2F394D),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}
class CustomCard extends StatelessWidget {
  CustomCard({required this.color, required this.child, required this.height});

  final Color color;
  final Widget child;

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
    );
  }
}