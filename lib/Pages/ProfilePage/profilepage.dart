import 'package:flutter/material.dart';
import 'package:flutter_course/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../Components/rounded_container.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const MyProfile();
  }
}

class ProfileData extends StatelessWidget {
  const ProfileData({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          width: 25,
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 25),
          ),
        )
      ],
    );
  }
}

class MyProfile extends StatelessWidget {
  static const String id = 'ProfilePage';
  const MyProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Expanded(
                child: RoundedContainer(
                  boxColor: thirdLayerColor,
                  boxChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: fourthLayerColor,
                          foregroundColor: Colors.white,
                          radius: 60,
                          child: Icon(
                            Icons.person,
                            size: 90,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Mahmoud Elmaghraby',
                          style: TextStyle(fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Divider(
                        color: Colors.white,
                        indent: 30,
                        endIndent: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ProfileData(
                          text: 'mah1234@gmail.com',
                          icon: Icons.email,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ProfileData(
                          text: '+2012345690',
                          icon: Icons.phone,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: RoundedContainer(
                  boxColor: thirdLayerColor,
                  boxChild: Column(
                    children: [
                      const Text(
                        'Vehicle\'s Info',
                        style: TextStyle(fontSize: 24),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ProfileData(
                            text: 'Brand: Seat', icon: FontAwesomeIcons.car),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ProfileData(
                            text: 'Model: Leon',
                            icon: FontAwesomeIcons.carSide),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ProfileData(
                            text: 'Color: Blue',
                            icon: FontAwesomeIcons.palette),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ProfileData(
                            text: 'Motor Type: ',
                            icon: FontAwesomeIcons.wrench),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Periodic Services'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
