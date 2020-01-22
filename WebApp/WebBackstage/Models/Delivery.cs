using System;
using System.Collections.Generic;

namespace WebBackstage.Models
{
    public partial class Delivery
    {
        public int DeliveryId { get; set; }
        public int UsersId { get; set; }
        public string Consignee { get; set; }
        public string Complete { get; set; }
        public string Phone { get; set; }

        public virtual Users Users { get; set; }
    }
}
