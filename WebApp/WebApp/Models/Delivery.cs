using System;
using System.Collections.Generic;

namespace WebApp.Models
{
    public partial class Delivery
    {
        public Delivery()
        {
            UsersNavigation = new HashSet<Users>();
        }

        public int DeliveryId { get; set; }
        public int UsersId { get; set; }
        public string Consignee { get; set; }
        public string Complete { get; set; }
        public string Phone { get; set; }

        public virtual Users Users { get; set; }
        public virtual ICollection<Users> UsersNavigation { get; set; }
    }
}
