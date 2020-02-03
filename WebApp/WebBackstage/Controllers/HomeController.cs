using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
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
        private IWebHostEnvironment _hostingEnvironment;
        public HomeController(ILogger<HomeController> logger, ChangeDBContext context, IWebHostEnvironment hostingEnvironment)
        {
            _logger = logger;
            _context = context;
            _hostingEnvironment = hostingEnvironment;
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
        public IActionResult Index(string Exit = null)
        {
            if (Exit == "EXIT")
            {
                HttpContext.Session.Remove("AdminUser");
                HttpContext.Session.Remove("AdminUserId");
            }
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }

            return View();
        }
        public async Task<ActionResult> UsersManage()//用户管理
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }

            var recvUsers = await _context.Users.ToListAsync();

            return View(recvUsers);
        }
        public async Task<ActionResult> DeleteUsers(int UsersId)//删除用户
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            var recvUsers = await _context.Users.FindAsync(UsersId);
            _context.Users.Remove(recvUsers);
            await _context.SaveChangesAsync();

            return RedirectToAction("UsersManage", "Home");
        }

        public async Task<ActionResult> NewsManage()//促销资讯
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }

            var recvNews = await _context.News.ToListAsync();

            return View(recvNews);
        }
        public async Task<ActionResult> AddNews(int NewsId =0)//新建促销资讯
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            if (NewsId ==0)
            {
                ViewBag.NewsType = "add";
                return View();
            }
            else
            {
                ViewBag.NewsType = "update";
                var recvNews = await _context.News.FindAsync(NewsId);
                return View(recvNews);
            }            
        }
        [HttpPost]
        public async Task<ActionResult> AddNews(IFormFile files, News news)//添加商品
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            if (news.NewsId >0)//修改
            {
                _context.Update(news);
                await _context.SaveChangesAsync();
            }
            else
            {
                var fileName = files.FileName;
                var filePath = _hostingEnvironment.WebRootPath + @"\images\" + fileName;//获取wwwboot目录
                                                                                        //根据路径创建文件
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    await files.CopyToAsync(stream);
                }
                news.PhotoUrl = fileName;
                _context.Add(news);
                await _context.SaveChangesAsync();
            }          

            return RedirectToAction("NewsManage", "Home");
        }
        public async Task<ActionResult> DeleteNews(int NewsId)//删除促销资讯
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            var recvNews = await _context.News.FindAsync(NewsId);
            _context.News.Remove(recvNews);
            await _context.SaveChangesAsync();

            return RedirectToAction("NewsManage", "Home");
        }
        public async Task<ActionResult> CancelNewsTop(int NewsId)//取消促销资讯置顶
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            var recvNews = await _context.News.FindAsync(NewsId);
            recvNews.States = recvNews.States == 0 ? 1:0;
            _context.Update(recvNews);
            await _context.SaveChangesAsync();
            return RedirectToAction("NewsManage", "Home");
        }
        public async Task<ActionResult> GoodsManage()//商品管理
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            
            var recvProduct = await _context.Product.Select(p=>new Product {
                ProductId=p.ProductId,
                CategoryId=p.CategoryId,
                Title =p.Title,
                MarketPrice = p.MarketPrice,
                Price = p.Price,
                Stock = p.Stock,
                Photo=p.Photo,
                Category = p.Category
            }).ToListAsync();

            return View(recvProduct);
        }
        public async Task<ActionResult> AddGoods()//添加商品
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            var recvCategory = await _context.Category.Where(p=>p.CategoryId==p.ParentId).ToListAsync();
            return View(recvCategory);
        }
        [HttpPost]
        public async Task<ActionResult> AddGoods(Product product)//添加商品
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            product.PostTime = DateTime.Now;
            _context.Add(product);
            await _context.SaveChangesAsync();

            return RedirectToAction("GoodsManage", "Home");
        }
        public async Task<ActionResult> EditGoods(int ProductId)//编辑商品
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            var recvProduct = await _context.Product.FindAsync(ProductId);
            ViewBag.ProductContent = recvProduct.Content.ToString();
            return View(recvProduct);
        }
        [HttpPost]
        public async Task<ActionResult> EditGoods(Product product)//编辑商品
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }            
            _context.Update(product);
            await _context.SaveChangesAsync();

            return RedirectToAction("GoodsManage", "Home");
        }
        public async Task<ActionResult> GoodsPic(int ProductId,string Title)//商品图片
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            ViewBag.ProductId = ProductId;
            ViewBag.ProductName = Title;

            var recvPhoto = await _context.Photo.Where(p => p.ProductId == ProductId).ToListAsync();
            return View(recvPhoto);
        }
        [HttpPost]
        public async Task<ActionResult> GoodsPic(IFormCollection Form)//添加商品图片
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            if (Form.Files.Count>0)
            {
                foreach (var item in Form.Files)
                {
                    var fileName = item.FileName;
                    var filePath = _hostingEnvironment.WebRootPath + @"\images\" + fileName;//获取wwwboot目录
                    //根据路径创建文件
                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await item.CopyToAsync(stream);
                    }
                    _context.Add(new Photo() {
                        ProductId = int.Parse(Form["ProductId"].ToString()),
                        PhotoUrl = fileName
                    }) ;
                    await _context.SaveChangesAsync();
                }
            }
            
            return RedirectToAction("GoodsPic", "Home", new { ProductId = Form["ProductId"], Title = Form["Title"] }); 
        }
        public async Task<ActionResult> DelGoodsPic(int PhotoId, int ProductId,string Title)//删除商品图片
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            var recvPhoto = await _context.Photo.FindAsync(PhotoId);
            _context.Photo.Remove(recvPhoto);
            await _context.SaveChangesAsync();
            return RedirectToAction("GoodsPic", "Home", new { ProductId = ProductId, Title = Title });
        }
        public async Task<ActionResult> GoodsInfo(int ProductId)//商品详情
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }
            var recvProduct = await _context.Product.Select(p => new Product
            {
                ProductId = p.ProductId,
                CategoryId = p.CategoryId,
                Title = p.Title,
                MarketPrice = p.MarketPrice,
                Price = p.Price,
                Content=p.Content,
                Stock = p.Stock,
                Photo = p.Photo,
                Category = p.Category
            }).Where(p=>p.ProductId== ProductId).FirstOrDefaultAsync();
            ViewBag.imgSrc = recvProduct.Photo.FirstOrDefault().PhotoUrl;
            var recvAppraise = await _context.Appraise.Where(p => p.ProductId == ProductId).ToListAsync();
            ViewData["Appraise"] = recvAppraise;
            ViewBag.AppraiseNum = recvAppraise.Count;
            ViewBag.ProductNum = await _context.OrdersDetail.Where(p => p.ProductId == ProductId).SumAsync(p=>p.Quantity);
            

            return View(recvProduct);
        }
        public async Task<ActionResult> DeleteGoods(int ProductId)//删除商品
        {
            if (!ReLogin())
            {
                return RedirectToAction("Index", "Login");
            }            
            var recvOrderD = await _context.OrdersDetail.Where(p => p.ProductId == ProductId).ToListAsync();
            if (recvOrderD.Count == 0)
            {
                var recvPhoto = await _context.Photo.Where(p => p.ProductId == ProductId).ToListAsync();
                foreach (var item in recvPhoto)
                {
                    _context.Photo.Remove(item);
                    await _context.SaveChangesAsync();
                }
                var recvFavorite = await _context.Favorite.Where(p => p.ProductId == ProductId).ToListAsync();
                foreach (var item in recvFavorite)
                {
                    _context.Favorite.Remove(item);
                    await _context.SaveChangesAsync();
                }
                var recvProduct = await _context.Product.FindAsync(ProductId);
                _context.Product.Remove(recvProduct);
                await _context.SaveChangesAsync();
            }
            
            return RedirectToAction("GoodsManage", "Home");
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
