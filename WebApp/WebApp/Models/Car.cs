using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace WebApp.Models
{
    public partial class Car
    {
        public int CarId { get; set; }
        public int ProductId { get; set; }        
        public DateTime AddDay { get; set; }
        public int ProductNum { get; set; }
        public int UsersId { get; set; }
        public virtual WebApp.Models.Product Product { get; set; }
        public virtual WebApp.Models.Users Users { get; set; }
    }
}
