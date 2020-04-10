import 'package:honours/helpers/AwsGatewayHelper.dart';
import 'package:honours/model/User.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:password/password.dart';
import 'package:random_string/random_string.dart';

class EmailHelper {

  void sendEmail(User recipientUserAccount, String recipientEmail) async {
    String username = "motodocs172@gmail.com";
    String password = "motodocmailserverpass";

    final smtpServer = gmail(username, password);
    // Creating the Gmail server
    String newPassword = randomAlphaNumeric(10);
    recipientUserAccount.password = Password.hash(newPassword, PBKDF2());
    print(recipientUserAccount.bikes);
    updateUser(recipientUserAccount);
    // Create our email message.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(recipientEmail) //recipent email//cc Recipents emailsmails
      ..subject = 'Password reminder' //subject of the email
      ..text = 'You recently requested a password reminder from the Motodocs application.'
          'if this was not you, please log into your account and change your password immediately.'
          'If this was you, then it is encouraged that you change your password through the application'
          'after logging in, in order to ensure a good level of security for your account. '
          '\n '
          'Your password for Motodocs is - $newPassword'; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n'+ e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }
}