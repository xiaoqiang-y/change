using System;
using System.Collections.Generic;

namespace WebBackstage.Models
{
    public partial class Car
    {
        public int CarId { get; set; }
        public int? ProductId { get; set; }
        public DateTime? AddDay { get; set; }
        public int? ProductNum { get; set; }
        public int? UsersId { get; set; }

        public virtual Product Product { get; set; }
        public virtual Users Users { get; set; }
    }
}
