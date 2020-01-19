﻿using System;
using System.Collections.Generic;

namespace WebApp.Models
{
    public partial class Photo
    {
        public int PhotoId { get; set; }
        public int ProductId { get; set; }
        public string PhotoUrl { get; set; }

        public virtual Product Product { get; set; }
    }
}
