using System;
using System.Collections.Generic;

namespace WebApp.Models
{
    public partial class AdminUser
    {
        public int AdminUsersId { get; set; }
        public string UserName { get; set; }
        public string Pwd { get; set; }
        public int Role { get; set; }
    }
}
