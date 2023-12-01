import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: const Text(
          "Privacy Policy",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Privacy Policy",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              Text(
                "Sreenath built the BroLearn app as a Free app. This SERVICE is provided by Sreenath at no cost and is intended for use as is.\n\nThis page is used to inform visitors regarding my policies with the collection  use and disclosure of Personal Information if anyone decided to use my Service.\n\nIf you choose to use my Service, then you agree to the collection and use of information in relation to this policy.The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\n\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at BroLearn unless otherwise defined in this Privacy Policy.\n\nInformation Collection and Use\n\nFor a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to Name,Age,Place,Mobile Number,Email,Education,Password,Profile image,Video Link,video title,Location details,Batch Number,Description,event name,venue,time,Sticky note title,sticky note description,date. The information that I request will be retained on your device and is not collected by me in any way.\n\nCookies\n\nCookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.\n\nThis Service does not use these cookies explicitly. However, the app may use third-party code and libraries that use cookies to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.\n\nService Providers\n\nI may employ third-party companies and individuals due to the following reasons To facilitate our Service To provide the Service on our behalf To perform Service related services or To assist us in analyzing how our Service is used.I want to inform users of this Service that these third parties have access to their Personal Information. The reason is to perform the tasks assigned to them on our behalf. However, they are obligated not to disclose or use the information for any other purpose.Security I value your trust in providing us your Personal Information, thus we are striving to use commercially acceptable means of protecting it. But remember that no method of transmission over the internet, or method of electronic storage is 100% secure and reliable, and I cannot guarantee its absolute security.Links to Other Sites This Service may contain links to other sites. If you click on a third-party link, you will be directed to that site. Note that these external sites are not operated by me. Therefore, I strongly advise you to review the Privacy Policy of these websites. I have no control over and assume no responsibility for the content, privacy policies, or practices of any third-party sites or services.\n\nChildrens Privacy\n\n I do not knowingly collect personallyidentifiable information from children. I  encourage all children to never submit any personallyidentifiable information through the Application  Services.I encourage parents and legal guardians to monitor their childrens Internet usage and to help enforce this Policy by instructing their children never to provide personally identifiable information through the Application  Services without their permission. If you have reason to believe that a child has provided personally identifiable information to us through the Application or Services, please contact us. You must also be at least 16 years of age to consent to the processing of your personally identifiable information in your country (in some countries we may allow your parent or guardian to do so on your behalf).Changes to This Privacy Policy I may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Privacy Policy on this page.This policy is effective as of 2023-12-01 Contact Us If you have any questions or suggestions about my Privacy Policy, do not hesitate to \n\ncontact me at sreenathsreeswaminathan@gmail.com.",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
