import 'package:flutter/material.dart';
import 'package:custom_clippers/custom_clippers.dart';

class FAQsPage extends StatelessWidget {
  const FAQsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 72, 119, 75),
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10, left: 5),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back),
            ),
          ),
          leadingWidth: 20,
          title: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const ClipOval(
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/FAQsIcon.jpg'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Brototype FAQS',
                        style: TextStyle(fontSize: 19),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'online',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/wtsppBGnd.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 80),
            child: Column(
              children: [
                ChatSample(),
                // Additional ChatSamples can be added here.
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> dummyMessages = [
      // Add 10 more dummy messages here
      "Who is Brocamp for?",
      "Anyone who wants to learn Computer Programming and build a good career as a Software Engineer😀. ",
      "Do I need any prior knowledge/ experience in computer programming to join Brocamp? ",
      "No, you don’t require any prior knowledge / experience in computer programming😀.",
      "Do I need a degree to join Brocamp?",
      "No, you don’t need any degree or educational qualifications😀.",
      "What are the eligibility criteria to join Brocamp?",
      "Applicants should have basic mathematical skills such as addition, subtraction,multiplication and division.➕➖➗✖",
      "Can I learn a specific domain like cybersecurity, data science, AI/ML etc., at Brocamp? ",
      "Yes, you can choose any domain as you wish🙂",
      "What are the admission procedures of Brocamp? ",
      "Submit an online application on this website.📧",
      "How do I prepare for the Brocamp interview?",
      "Brocamp interview consists of very basic programming questions and few general questions about yourself",
       "Can I apply again if I failed the interview?",
        "Yes, you can apply till you get qualified😀.",
       
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(dummyMessages.length, (index) {
        if (index % 2 != 0) {
          return Padding(
            padding: const EdgeInsets.only(right: 80),
            child: Container(
              child: ClipPath(
                clipper: UpperNipMessageClipperTwo(MessageType.receive),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 10),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text(
                    dummyMessages[index],
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 20, left: 80, bottom: 15),
            child: Container(
              child: ClipPath(
                clipper: UpperNipMessageClipperTwo(MessageType.send),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 10, right: 20),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE4FDCA),
                  ),
                  child: Text(
                    dummyMessages[index],
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
