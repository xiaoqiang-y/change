using System;
using System.Collections.Generic;

namespace WebApp.Models
{
    public partial class OrdersDetail
    {
        public int OrdersDetailId { get; set; }
        public string OrdersId { get; set; }
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public int States { get; set; }
        public string PhotoUrl { get; set; }
        public string Title { get; set; }
        public decimal Price { get; set; }
        public virtual Orders Orders { get; set; }
        public virtual Product Product { get; set; }
    }
}
