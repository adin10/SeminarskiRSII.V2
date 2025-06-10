//using MimeKit;
//using MimeKit.Text;
//using MailKit.Net.Smtp;
//using Newtonsoft.Json;
//using System.Net.Mail;
//using SmtpClient = MailKit.Net.Smtp.SmtpClient;

//namespace SeminarskiRSII.RabbitMQConsumer
//{
//    public class MailService
//    {
//        public void Send(string message)
//        {
//            try
//            {
//                string smtpServer = Environment.GetEnvironmentVariable("SMTP_SERVER") ?? "smtp.gmail.com";
//                int smtpPort = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT") ?? "465");
//                string fromMail = Environment.GetEnvironmentVariable("SMTP_USERNAME") ?? "kenancopelj@gmail.com";
//                string password = Environment.GetEnvironmentVariable("SMTP_PASSWORD") ?? "zvjq jzmd bmmc lhxk";

//                var emailData = JsonConvert.DeserializeObject<MailDto>(message);
//                var senderEmail = emailData!.Sender;
//                var recipientEmail = emailData.Recipient;
//                var subject = emailData.Subject;
//                var content = emailData.Content;

//                var mailObj = new MimeMessage();

//                mailObj.Sender = MailboxAddress.Parse(senderEmail);

//                mailObj.To.Add(MailboxAddress.Parse(recipientEmail));

//                mailObj.Subject = subject;
//                mailObj.Body = new TextPart(TextFormat.Plain)
//                {
//                    Text = content
//                };

//                using (var smtpClient = new SmtpClient())
//                {
//                    smtpClient.Connect(smtpServer, smtpPort, true);
//                    smtpClient.Authenticate(fromMail, password);
//                    smtpClient.Send(mailObj);
//                    smtpClient.Disconnect(true);
//                }

//            }
//            catch (Exception ex)
//            {
//                Console.WriteLine($"Error sending email: {ex.Message}");
//            }
//        }
//    }
//}

using MailKit.Net.Smtp;
using MailKit.Security;
using MimeKit;
using MimeKit.Text;
using Newtonsoft.Json;

namespace SeminarskiRSII.RabbitMQConsumer
{
    public class MailService
    {
        public void Send(string message)
        {
            try
            {
                string smtpServer = Environment.GetEnvironmentVariable("SMTP_SERVER") ?? "smtp.gmail.com";
                int smtpPort = int.Parse(Environment.GetEnvironmentVariable("SMTP_PORT") ?? "587");
                string fromMail = Environment.GetEnvironmentVariable("SMTP_USERNAME") ?? "";
                string password = Environment.GetEnvironmentVariable("SMTP_PASSWORD") ?? "";

                var emailData = JsonConvert.DeserializeObject<MailDto>(message);

                if (emailData == null)
                {
                    Console.WriteLine("Email data could not be parsed.");
                    return;
                }

                var mailObj = new MimeMessage();
                mailObj.From.Add(MailboxAddress.Parse(fromMail));
                mailObj.To.Add(MailboxAddress.Parse(emailData.Recipient));
                mailObj.Subject = emailData.Subject;
                mailObj.Body = new TextPart(TextFormat.Plain) { Text = emailData.Content };

                using var smtpClient = new SmtpClient();
                smtpClient.Connect(smtpServer, 465, SecureSocketOptions.SslOnConnect);
                smtpClient.Authenticate(fromMail, password);
                smtpClient.Send(mailObj);
                smtpClient.Disconnect(true);

                Console.WriteLine("Email sent successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending email: {ex.Message}");
            }
        }
    }
}
