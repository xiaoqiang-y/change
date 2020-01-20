using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using WebApp.Models;
using System.Security.Cryptography;

namespace WebApp.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        public ActionResult Index()
        {           
            return View();
        }
        [HttpPost]
        public async Task<ActionResult> Index(Users users)
        {
            HttpClient client = new HttpClient();
            //var result = await client.GetStringAsync("http://localhost:8080/api/Users");
            var result = await client.GetStringAsync("http://localhost:8080/api/Users?UserName=" + users.UserName);
            if (result!="")
            {
                var recvUser = JsonConvert.DeserializeObject<Users>(result);
                string pagePwd = MD5Encrypt.Encrypt(users.Pwd);
                if (recvUser.UserName == users.UserName && recvUser.Pwd.ToLower() == pagePwd.ToLower())
                {
                    HttpContext.Session.SetString("LoginUser", recvUser.UserName);//缓存当前登录用户
                    return RedirectToAction("Index","Home");
                }
            }            
            return View();
        }

        // GET: Login/Details/5
        public ActionResult Details(int id)
        {
            return View();
        }

        // GET: Login/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Login/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register()
        {
            
                return View();
            
        }

        // GET: Login/Edit/5
        public ActionResult Edit(int id)
        {
            return View();
        }

        // POST: Login/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(int id, IFormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: Login/Delete/5
        public ActionResult Delete(int id)
        {
            return View();
        }

        // POST: Login/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(int id, IFormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}