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

        public async Task<ActionResult> OrderManage(int States = -1)//查询订单
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            ViewBag.States = States;
            List<Orders> recvOrder = null;
            if (States !=-1)
            {
                recvOrder = await _context.Orders.Where(p=>p.States == States).ToListAsync();
            }
            else
            {
                recvOrder = await _context.Orders.ToListAsync();
            }
            return View(recvOrder);
        }

        public async Task<ActionResult> OrderDetail(string OrdersId)//订单详情
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            var recvOrder = await _context.Orders.Where(p=>p.OrdersId== OrdersId).ToListAsync();
            var recvUser = await _context.Users.Where(p => p.UsersId == recvOrder[0].UsersId).ToListAsync();
            var recvDelivery = await _context.Delivery.Where(p => p.DeliveryId == recvOrder[0].DeliveryId).ToListAsync();
            var recvOrderD = await _context.OrdersDetail.Where(p => p.OrdersId == OrdersId).ToListAsync();
            ViewData["OrdersId"] = recvOrder[0].OrdersId;
            ViewData["UserName"] = recvUser[0].UserName;
            ViewData["Orderdate"] = recvOrder[0].Orderdate;
            ViewData["Total"] = recvOrder[0].Total;
            ViewData["Consignee"] = recvDelivery[0].Consignee;
            ViewData["Complete"] = recvDelivery[0].Complete;
            ViewData["Phone"] = recvDelivery[0].Phone;
            ViewData["States"] = recvOrder[0].States;
            ViewData["Remark"] = recvOrder[0].Remark;

            return View(recvOrderD);
        }
        public async Task<ActionResult> Shipments(string OrdersId)//订单发货
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            var recvOrder = await _context.Orders.FindAsync(OrdersId);
            recvOrder.States = 2;//订单发货

            _context.Update(recvOrder);
            await _context.SaveChangesAsync();
            
            return RedirectToAction("OrderManage", "Home");

            //return View(recvOrder);
        }
        public async Task<IActionResult> DeleteOrder(string OrdersId)//删除订单
        {
            if (OrdersId == null)
            {
                return NotFound();
            }

            var recvOrder = await _context.Orders.FindAsync(OrdersId);
            double minutes = (DateTime.Now - recvOrder.Orderdate).TotalMinutes;
            if (minutes > 60)//超过一个小时
            {
                var recvOrderD = await _context.OrdersDetail.Where(p => p.OrdersId == OrdersId).ToListAsync();
                foreach (var item in recvOrderD)
                {
                    _context.OrdersDetail.Remove(item);
                    await _context.SaveChangesAsync();
                }
                _context.Orders.Remove(recvOrder);
                await _context.SaveChangesAsync();
            }
            return RedirectToAction("OrderManage", "Home");
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
