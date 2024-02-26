import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Member {
  final String name;
  final String description;
  final String imagePath;
  final String linkedinUrl;
  final String githubUrl;

  Member({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.linkedinUrl,
    required this.githubUrl,
  });
}

class SobreNosPage extends StatelessWidget {
  final List<Member> teamMembers = [
    Member(
      name: "BRUNO RENAN LUBIAN",
      description: "Estudante Entra21 - 2024 do curso Flutter, Blumenau - SC",
      imagePath: "assets/images/bruno.png",
      linkedinUrl: "https://www.linkedin.com/in/brunolubian/",
      githubUrl: "https://github.com/brunolubiandnca",
    ),
    Member(
      name: "GERALDO RONDINELE P. LIMA",
      description: "Estudante Entra21 - 2024 do curso Flutter, Blumenau - SC",
      imagePath: "assets/images/geraldo.png",
      linkedinUrl: "https://www.linkedin.com/in/geraldorondinele/",
      githubUrl: "https://github.com/grplima",
    ),
    Member(
      name: "THIAGO SOUZA SILVA",
      description: "Estudante Entra21 - 2024 do curso Flutter, Blumenau - SC",
      imagePath: "assets/images/thiago.jpg",
      linkedinUrl: "https://www.linkedin.com/in/thiago-souzaa/",
      githubUrl: "https://github.com/ThiagoSouza-a",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF145DA0),
          title: Text(
            "Sobre nós",
            style: TextStyle(
              color: Color(0xFFEDC71F),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFEDC71F),),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),

        body: Container(
        color: Color(0xFF145DA0),
        child: ListView(
          children: [
            Image.asset(
              'assets/images/logohorizontal1.png',
              fit: BoxFit.fitWidth,
            ),
            Column(
              children: teamMembers
                  .map((member) => MemberTile(member: member))
                  .toList(),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class MemberTile extends StatelessWidget {
  final Member member;

  MemberTile({required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(member.imagePath),
        ),
        title: Text(member.name),
        subtitle: Text(member.description),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberDetailsScreen(member: member),
            ),
          );
        },
      ),
    );
  }
}

class MemberDetailsScreen extends StatelessWidget {
  final Member member;

  MemberDetailsScreen({required this.member});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(member.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: CircleAvatar(
                backgroundImage: AssetImage(member.imagePath),
                radius: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  member.description,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _launchURL(member.linkedinUrl);
                  },
                  child: Text('LinkedIn'),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    _launchURL(member.githubUrl);
                  },
                  child: Text('GitHub'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunchUrl(url as Uri)) {
      await launchUrl(url as Uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
