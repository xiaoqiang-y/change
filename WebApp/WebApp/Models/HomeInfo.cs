using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApp.Models
{
    public class HomeInfo
    {
        public int ProductId { get; set; }
        public int CategoryId { get; set; }
        public int ParentId { get; set; }
        public string Title { get; set; }
        public string CateName { get; set; }
        public string PhotoUrl { get; set; }
        public decimal MarketPrice { get; set; }
        public decimal Price { get; set; }

    }
}
