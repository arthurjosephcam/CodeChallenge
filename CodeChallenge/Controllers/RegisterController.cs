using CodeChallenge.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net.Http;
using System.Net.Mail;
using System.Web;
using System.Web.Hosting;
using System.Web.Mvc;

namespace CodeChallenge.Controllers
{
    /*Please see my comments on code, thank you! Arthur Cam.*/
    public class RegisterController : Controller
    {
        CMWRegistrationEntities db = new CMWRegistrationEntities(); 
        // GET: Register
        public ActionResult Index()
        {
            return View();
        }

        public bool RegisterNew(ContactInfo contact)
        {
            var ret = true;
            //In an ideal design, I would return an http response, or an object. 
            //But for now, bool is ok. 
            try
            {
                db.ContactInfoes.Add(contact);
                db.SaveChanges();
                ret = true;
            }
            catch
            {
                //regularly don't catch and throw exception to log, but for now, I just catch it.
                ret = false;
            }
            if (ret)
            {
                SendEmail(contact);
            }
            return ret;
        }

        private void SendEmail(ContactInfo contactInfo)
        {
            //In normal design, I would never send emails directly, best way is to flag it unsent in DB and send with a webjob or another process. 
            //But for demo, wanted to keep it simple. 


            string from = ConfigurationManager.AppSettings["EmailFrom"].ToString();
            string emailPassword = ConfigurationManager.AppSettings["EmailPassword"].ToString();
            string to = contactInfo.Email;
            string subject = "CONFIRMATION - Speaker Training Meeting"; 

            //I could make it html.
            string MailBody = System.IO.File.ReadAllText(HostingEnvironment.MapPath("~/App_Data/") + "Mail.html");
            MailBody= MailBody.Replace("{{Name}}", contactInfo.FirstName + ' ' + contactInfo.LastName);
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(from);
            mail.To.Add(new MailAddress(to));
            mail.Subject = subject;
            mail.Body = MailBody;


            SmtpClient smtpClient = new SmtpClient();
            smtpClient.Host = ConfigurationManager.AppSettings["SMTPHost"].ToString();
            smtpClient.Port = 587;
            smtpClient.EnableSsl = true;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.DeliveryMethod = SmtpDeliveryMethod.Network;
            smtpClient.Credentials = new System.Net.NetworkCredential(from, emailPassword);

            try
            {
                smtpClient.Send(mail);
            }
            catch
            {
                //throw new Exception("Error sending email"); //I will not throw it, because there is no logging to catch.
            }

        }
    }
}