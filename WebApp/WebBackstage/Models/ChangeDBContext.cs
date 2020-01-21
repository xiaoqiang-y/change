using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace WebBackstage.Models
{
    public partial class ChangeDBContext : DbContext
    {
        public ChangeDBContext()
        {
        }

        public ChangeDBContext(DbContextOptions<ChangeDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<AdminUser> AdminUser { get; set; }
        public virtual DbSet<Appraise> Appraise { get; set; }
        public virtual DbSet<Car> Car { get; set; }
        public virtual DbSet<Category> Category { get; set; }
        public virtual DbSet<Delivery> Delivery { get; set; }
        public virtual DbSet<Favorite> Favorite { get; set; }
        public virtual DbSet<News> News { get; set; }
        public virtual DbSet<Orders> Orders { get; set; }
        public virtual DbSet<OrdersDetail> OrdersDetail { get; set; }
        public virtual DbSet<Photo> Photo { get; set; }
        public virtual DbSet<Product> Product { get; set; }
        public virtual DbSet<Users> Users { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. See http://go.microsoft.com/fwlink/?LinkId=723263 for guidance on storing connection strings.
                optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=ChangeDB; Integrated Security=True;");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AdminUser>(entity =>
            {
                entity.HasKey(e => e.AdminUsersId)
                    .HasName("PK__AdminUse__5619BF1F78E99778");

                entity.Property(e => e.Pwd)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Role).HasColumnName("role");

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(50);
            });

            modelBuilder.Entity<Appraise>(entity =>
            {
                entity.Property(e => e.Content).IsRequired();

                entity.Property(e => e.RateTime)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.Appraise)
                    .HasForeignKey(d => d.ProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Appraise__Produc__5165187F");

                entity.HasOne(d => d.Users)
                    .WithMany(p => p.Appraise)
                    .HasForeignKey(d => d.UsersId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Appraise__UsersI__52593CB8");
            });

            modelBuilder.Entity<Car>(entity =>
            {
                entity.Property(e => e.AddDay).HasColumnType("datetime");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.Car)
                    .HasForeignKey(d => d.ProductId)
                    .HasConstraintName("FK__Car__ProductId__73BA3083");

                entity.HasOne(d => d.Users)
                    .WithMany(p => p.Car)
                    .HasForeignKey(d => d.UsersId)
                    .HasConstraintName("FK__Car__UsersId__74AE54BC");
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.Property(e => e.CateName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.Parent)
                    .WithMany(p => p.InverseParent)
                    .HasForeignKey(d => d.ParentId)
                    .HasConstraintName("FK__Category__Parent__534D60F1");
            });

            modelBuilder.Entity<Delivery>(entity =>
            {
                entity.Property(e => e.Complete)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.Property(e => e.Consignee)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Phone)
                    .IsRequired()
                    .HasMaxLength(12);

                entity.HasOne(d => d.Users)
                    .WithMany(p => p.Delivery)
                    .HasForeignKey(d => d.UsersId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_Delivery_UsersId");
            });

            modelBuilder.Entity<Favorite>(entity =>
            {
                entity.HasOne(d => d.Product)
                    .WithMany(p => p.Favorite)
                    .HasForeignKey(d => d.ProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Favorite__Produc__5535A963");

                entity.HasOne(d => d.Users)
                    .WithMany(p => p.Favorite)
                    .HasForeignKey(d => d.UsersId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Favorite__UsersI__5629CD9C");
            });

            modelBuilder.Entity<News>(entity =>
            {
                entity.Property(e => e.Content).IsRequired();

                entity.Property(e => e.Ntypes)
                    .IsRequired()
                    .HasColumnName("NTypes")
                    .HasMaxLength(10);

                entity.Property(e => e.PhotoUrl)
                    .IsRequired()
                    .HasMaxLength(200);

                entity.Property(e => e.PushTime).HasColumnType("datetime");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(100);
            });

            modelBuilder.Entity<Orders>(entity =>
            {
                entity.Property(e => e.DeliveryDate).HasColumnType("date");

                entity.Property(e => e.Orderdate)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Remark).HasMaxLength(500);

                entity.Property(e => e.States).HasDefaultValueSql("((0))");

                entity.Property(e => e.Total).HasColumnType("money");
            });

            modelBuilder.Entity<OrdersDetail>(entity =>
            {
                entity.Property(e => e.States).HasDefaultValueSql("((0))");

                entity.HasOne(d => d.Orders)
                    .WithMany(p => p.OrdersDetail)
                    .HasForeignKey(d => d.OrdersId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrdersDet__Order__4F7CD00D");

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.OrdersDetail)
                    .HasForeignKey(d => d.ProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__OrdersDet__Produ__5812160E");
            });

            modelBuilder.Entity<Photo>(entity =>
            {
                entity.Property(e => e.PhotoUrl).HasMaxLength(200);

                entity.HasOne(d => d.Product)
                    .WithMany(p => p.Photo)
                    .HasForeignKey(d => d.ProductId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Photo__ProductId__59063A47");
            });

            modelBuilder.Entity<Product>(entity =>
            {
                entity.Property(e => e.MarketPrice).HasColumnType("money");

                entity.Property(e => e.PostTime)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Price).HasColumnType("money");

                entity.Property(e => e.Title)
                    .IsRequired()
                    .HasMaxLength(100);

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.Product)
                    .HasForeignKey(d => d.CategoryId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK__Product__Categor__59FA5E80");
            });

            modelBuilder.Entity<Users>(entity =>
            {
                entity.HasIndex(e => e.UserName)
                    .HasName("UQ__Users__C9F284568CECC44A")
                    .IsUnique();

                entity.Property(e => e.Email)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.Nick).HasMaxLength(50);

                entity.Property(e => e.Pwd)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.Property(e => e.UserName)
                    .IsRequired()
                    .HasMaxLength(50);

                entity.HasOne(d => d.DeliveryNavigation)
                    .WithMany(p => p.UsersNavigation)
                    .HasForeignKey(d => d.DeliveryId)
                    .HasConstraintName("FK__Users__DeliveryI__5AEE82B9");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
