using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace CodeChallenge.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

        public bool CheckLogin(String password)
        {
            if (password == "abc123!")
                return true;
            else
                return false;
        }
    }
}