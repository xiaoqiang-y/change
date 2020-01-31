using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using WebBackstage.Models;

namespace WebBackstage.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly ChangeDBContext _context;

        public HomeController(ILogger<HomeController> logger, ChangeDBContext context)
        {
            _logger = logger;
            _context = context;
        }
        public bool ReLogin()
        {
            if (!string.IsNullOrEmpty(HttpContext.Session.GetString("AdminUser")))
            {
                ViewBag.LoginName = HttpContext.Session.GetString("AdminUser");//显示界面当前登录用户
                ViewBag.LoginId = HttpContext.Session.GetString("AdminUserId");//显示界面当前登录用户
                return true;
            }
            else
            {
                return false;
                //
            }
            
        }
        public IActionResult Index()
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }

            return View();
        }

        public async Task<ActionResult> OrderManage()
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            var recvUser = await _context.Orders.ToListAsync();

            return View(recvUser);
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
