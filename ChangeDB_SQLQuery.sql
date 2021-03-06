USE [master]
GO
/****** Object:  Database [ChangeDB]    Script Date: 2020/1/22 21:55:29 ******/
CREATE DATABASE [ChangeDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ChangeDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ChangeDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ChangeDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\ChangeDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ChangeDB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ChangeDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ChangeDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ChangeDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ChangeDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ChangeDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ChangeDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ChangeDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ChangeDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ChangeDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ChangeDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ChangeDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ChangeDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ChangeDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ChangeDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ChangeDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ChangeDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ChangeDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ChangeDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ChangeDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ChangeDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ChangeDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ChangeDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ChangeDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ChangeDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ChangeDB] SET  MULTI_USER 
GO
ALTER DATABASE [ChangeDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ChangeDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ChangeDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ChangeDB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [ChangeDB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ChangeDB', N'ON'
GO
ALTER DATABASE [ChangeDB] SET QUERY_STORE = OFF
GO
USE [ChangeDB]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AdminUser]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AdminUser](
	[AdminUsersId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Pwd] [nvarchar](50) NOT NULL,
	[role] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AdminUsersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Appraise]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appraise](
	[AppraiseId] [int] IDENTITY(1,1) NOT NULL,
	[UsersId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[Grade] [int] NOT NULL,
	[RateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AppraiseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Car]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Car](
	[CarId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[AddDay] [datetime] NULL,
	[ProductNum] [int] NULL,
	[UsersId] [int] NULL,
	[PhotoUrl] [nvarchar](200) NULL,
	[Title] [nvarchar](100) NULL,
	[Price] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[CarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CateName] [nvarchar](50) NOT NULL,
	[ParentId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Delivery]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delivery](
	[DeliveryId] [int] IDENTITY(1,1) NOT NULL,
	[UsersId] [int] NOT NULL,
	[Consignee] [nvarchar](50) NOT NULL,
	[Complete] [nvarchar](200) NOT NULL,
	[Phone] [nvarchar](12) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DeliveryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Favorite]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Favorite](
	[FavoriteId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[UsersId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FavoriteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[News]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[News](
	[NewsId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[NTypes] [nvarchar](10) NOT NULL,
	[Content] [nvarchar](max) NOT NULL,
	[PhotoUrl] [nvarchar](200) NOT NULL,
	[PushTime] [datetime] NULL,
	[States] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[NewsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrdersId] [nvarchar](100) NOT NULL,
	[Orderdate] [datetime] NULL,
	[UsersId] [int] NOT NULL,
	[Total] [money] NULL,
	[DeliveryId] [int] NULL,
	[DeliveryDate] [date] NULL,
	[States] [int] NULL,
	[Remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__Orders__630B9956D0149506] PRIMARY KEY CLUSTERED 
(
	[OrdersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrdersDetail]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrdersDetail](
	[OrdersDetailId] [int] IDENTITY(1,1) NOT NULL,
	[OrdersId] [nvarchar](100) NOT NULL,
	[ProductId] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[States] [int] NULL,
	[PhotoUrl] [nvarchar](200) NULL,
	[Title] [nvarchar](100) NULL,
	[Price] [money] NULL,
 CONSTRAINT [PK__OrdersDe__ADE3F6D7943CDF70] PRIMARY KEY CLUSTERED 
(
	[OrdersDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Photo]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Photo](
	[PhotoId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[PhotoUrl] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[PhotoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](100) NOT NULL,
	[CategoryId] [int] NOT NULL,
	[MarketPrice] [money] NOT NULL,
	[Price] [money] NOT NULL,
	[Content] [nvarchar](max) NULL,
	[PostTime] [datetime] NULL,
	[Stock] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2020/1/22 21:55:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UsersId] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[Pwd] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Nick] [nvarchar](50) NULL,
	[DeliveryId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[UsersId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AdminUser] ON 

INSERT [dbo].[AdminUser] ([AdminUsersId], [UserName], [Pwd], [role]) VALUES (1, N'admin', N'e10adc3949ba59abbe56e057f20f883e', 1)
INSERT [dbo].[AdminUser] ([AdminUsersId], [UserName], [Pwd], [role]) VALUES (2, N'test', N'e10adc3949ba59abbe56e057f20f883e', 0)
SET IDENTITY_INSERT [dbo].[AdminUser] OFF
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (3, N'服装', 3)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (4, N'数码', 4)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (5, N'美食', 5)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (6, N'家居', 6)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (7, N'美妆', 7)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (8, N'母婴', 8)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (9, N'上装', 3)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (10, N'裙子', 3)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (11, N'裤子', 3)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (12, N'帽子', 3)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (13, N'鞋子', 3)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (14, N'手套', 3)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (15, N'手机', 4)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (16, N'电脑', 4)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (17, N'配件', 4)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (18, N'数码', 4)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (19, N'PC', 4)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (20, N'iPad', 4)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (21, N'蔬菜', 5)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (22, N'零食', 5)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (23, N'咖啡', 5)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (24, N'水果', 5)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (25, N'麻辣', 5)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (26, N'糖果', 5)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (27, N'家具', 6)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (28, N'厨具', 6)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (29, N'家纺', 6)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (30, N'餐具', 6)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (31, N'灯具', 6)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (32, N'卫浴', 6)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (33, N'护肤', 7)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (34, N'彩妆', 7)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (35, N'洗发', 7)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (36, N'护发', 7)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (37, N'护理', 7)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (38, N'染发', 7)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (39, N'奶粉', 8)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (40, N'辅食', 8)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (41, N'玩具', 8)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (42, N'喂养', 8)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (43, N'洗护', 8)
INSERT [dbo].[Category] ([CategoryId], [CateName], [ParentId]) VALUES (44, N'尿片', 8)
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Delivery] ON 

INSERT [dbo].[Delivery] ([DeliveryId], [UsersId], [Consignee], [Complete], [Phone]) VALUES (1, 1, N'尹先生', N'湖南工程职院崇美楼', N'13810832212')
INSERT [dbo].[Delivery] ([DeliveryId], [UsersId], [Consignee], [Complete], [Phone]) VALUES (2, 1, N'尹先生', N'湖南工程职院求实楼', N'13810832212')
INSERT [dbo].[Delivery] ([DeliveryId], [UsersId], [Consignee], [Complete], [Phone]) VALUES (3, 1, N'尹先生', N'湖南工程职院求真楼', N'13810832212')
INSERT [dbo].[Delivery] ([DeliveryId], [UsersId], [Consignee], [Complete], [Phone]) VALUES (4, 1, N'尹先生', N'湖南工程职院实训楼', N'13810832212')
INSERT [dbo].[Delivery] ([DeliveryId], [UsersId], [Consignee], [Complete], [Phone]) VALUES (5, 1, N'尹先生', N'湖南工程职院图书馆', N'13810832212')
INSERT [dbo].[Delivery] ([DeliveryId], [UsersId], [Consignee], [Complete], [Phone]) VALUES (6, 1, N'尹先生', N'湖南工程职院崇善楼', N'13810832212')
SET IDENTITY_INSERT [dbo].[Delivery] OFF
SET IDENTITY_INSERT [dbo].[Favorite] ON 

INSERT [dbo].[Favorite] ([FavoriteId], [ProductId], [UsersId]) VALUES (8, 8, 1)
SET IDENTITY_INSERT [dbo].[Favorite] OFF
SET IDENTITY_INSERT [dbo].[News] ON 

INSERT [dbo].[News] ([NewsId], [Title], [NTypes], [Content], [PhotoUrl], [PushTime], [States]) VALUES (1, N'疯狂大甩卖', N'促销活动', N'空前力度，实惠满满', N'cx1.jpg', CAST(N'2019-08-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[News] ([NewsId], [Title], [NTypes], [Content], [PhotoUrl], [PushTime], [States]) VALUES (4, N'卖不了吃亏卖不了上当', N'促销活动', N'走过的路过的进来瞧一瞧', N'cx2.jpg', CAST(N'2019-08-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[News] ([NewsId], [Title], [NTypes], [Content], [PhotoUrl], [PushTime], [States]) VALUES (5, N'好礼送送送', N'大宗礼品', N'买就送', N'hd1.jpg', CAST(N'2019-08-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[News] ([NewsId], [Title], [NTypes], [Content], [PhotoUrl], [PushTime], [States]) VALUES (6, N'充值有礼', N'大宗礼品', N'满1000送1000', N'hd2.jpg', CAST(N'2019-08-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[News] ([NewsId], [Title], [NTypes], [Content], [PhotoUrl], [PushTime], [States]) VALUES (7, N'详情咨询', N'活动咨询', N'活动咨询', N'zx.jpg', CAST(N'2019-08-05T00:00:00.000' AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[News] OFF
SET IDENTITY_INSERT [dbo].[Photo] ON 

INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (1, 4, N'f21.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (2, 5, N'f22.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (3, 6, N'f23.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (4, 8, N'衣服5.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (5, 9, N'衣服1.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (6, 10, N'衣服2.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (7, 11, N'衣服3.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (8, 12, N'衣服4.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (9, 13, N'f23.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (10, 14, N'f22.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (11, 15, N'f23.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (12, 16, N'f24.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (13, 17, N'f25.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (14, 18, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (15, 19, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (16, 20, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (17, 21, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (18, 22, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (20, 26, N'衣服5.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (21, 25, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (22, 24, N'f21.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (23, 25, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (24, 27, N'f22.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (25, 32, N'衣服1.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (26, 28, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (27, 29, N'衣服2.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (28, 30, N'f21.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (29, 31, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (30, 33, N'f21.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (31, 34, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (32, 35, N'f62.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (33, 36, N'f21.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (34, 37, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (35, 38, N'衣服3.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (36, 39, N'f21.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (37, 40, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (38, 41, N'衣服4.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (39, 42, N'f21.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (40, 43, N'f35.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (41, 44, N'衣服5.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (42, 23, N'衣服3.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (43, 45, N'f22.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (44, 47, N'衣服5.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (45, 50, N'衣服3.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (46, 48, N'f21.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (47, 51, N'f22.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (52, 7, N'f25.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (53, 46, N'f32.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (54, 49, N'f34.jpg')
INSERT [dbo].[Photo] ([PhotoId], [ProductId], [PhotoUrl]) VALUES (55, 52, N'f31.jpg')
SET IDENTITY_INSERT [dbo].[Photo] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (4, N'小米1', 16, 999.9900, 989.9900, N'<p>小米1</p>', CAST(N'2019-08-02T08:30:58.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (5, N'小米2', 16, 999.9900, 989.9900, N'小米2', CAST(N'2019-08-02T08:30:58.000' AS DateTime), 1)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (6, N'小米3', 16, 999.9900, 989.9900, N'小米3', CAST(N'2019-08-02T08:30:58.187' AS DateTime), 3)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (7, N'小米3', 16, 999.9900, 989.9900, N'小米3', CAST(N'2019-08-02T15:10:26.030' AS DateTime), 3)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (8, N'2019新款时髦裙子', 9, 109.0000, 69.5000, N'<p>2019新款时髦套装裙子</p><p>适合对象：女孩&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年龄：6岁</p><p>颜色：碎花&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;码子：通码</p>', CAST(N'2019-08-03T07:34:37.000' AS DateTime), 50)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (9, N'2019新款时髦运动装', 9, 159.0000, 79.0000, N'<p>2019新款时髦套装运动装</p>', CAST(N'2019-08-03T07:35:28.000' AS DateTime), 27)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (10, N'2019新款时髦淑女装', 9, 209.0000, 128.0000, N'<p>2019新款时髦套装淑女装</p>', CAST(N'2019-08-03T07:36:12.000' AS DateTime), 60)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (11, N'2019新款时髦运动套装', 10, 89.0000, 39.0000, N'<p>2019新款时髦套装运动套装</p>', CAST(N'2019-08-03T07:37:10.000' AS DateTime), 80)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (12, N'2019新款时髦公主裙', 12, 306.0000, 106.0000, N'<p>2019新款时髦套装公主裙</p>', CAST(N'2019-08-03T07:37:53.000' AS DateTime), 100)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (13, N'2019新款联想笔记本', 15, 4999.0000, 4599.0000, N'<p>2019新款联想笔记本电脑</p>', CAST(N'2019-08-03T07:38:36.000' AS DateTime), 10)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (14, N'2019新款惠普笔记本', 16, 5129.0000, 4899.0000, N'<p>2019新款惠普笔记本电脑</p>', CAST(N'2019-08-03T07:39:17.000' AS DateTime), 5)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (15, N'2019新款DELL笔记本', 17, 6000.0000, 5789.0000, N'<p>2019新款DELL笔记本电脑</p>', CAST(N'2019-08-03T07:39:48.000' AS DateTime), 6)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (16, N'2019新款华硕笔记本', 18, 4589.0000, 4000.0000, N'<p>2019新款华硕笔记本电脑</p>', CAST(N'2019-08-03T07:40:39.000' AS DateTime), 9)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (17, N'2019新款苹果笔记本', 19, 8999.0000, 8950.0000, N'<p>2019新款苹果笔记本电脑</p>', CAST(N'2019-08-03T07:41:10.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (18, N'轩尼诗VSOP Hennessy', 21, 500.0000, 300.0000, N'<p><span style="font-family: &quot;Microsoft YaHei&quot;; font-size: medium; text-align: center; background-color: rgb(231, 231, 231);">轩尼诗VSOP700ml Hennessy</span></p>', CAST(N'2019-08-03T07:43:35.000' AS DateTime), 10)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (19, N'白兰地VSOP Hennessy', 22, 400.0000, 200.0000, N'<p>白兰地VSOP700ml Hennessy</p>', CAST(N'2019-08-03T07:44:10.000' AS DateTime), 100)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (20, N'伏特加VSOP Hennessy', 23, 600.0000, 400.0000, N'<p>伏特加VSOP700ml Hennessy</p>', CAST(N'2019-08-03T07:44:48.000' AS DateTime), 12)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (21, N'RIO鸡尾酒', 25, 10.0000, 9.8000, N'<p>RIO鸡尾酒</p>', CAST(N'2019-08-03T07:45:44.000' AS DateTime), 120)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (22, N'法国XO皇家至尊', 25, 900.0000, 780.0000, N'<p>法国XO皇家至尊</p>', CAST(N'2019-08-03T07:46:21.000' AS DateTime), 5)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (23, N'2020新款时髦裙子', 9, 109.0000, 69.5000, N'<p>2019新款时髦套装裙子</p>', CAST(N'2019-08-03T07:34:37.000' AS DateTime), 50)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (24, N'2020新款苹果笔记本', 20, 8999.0000, 8950.0000, N'<p>2019新款苹果笔记本电脑</p>', CAST(N'2019-08-03T07:41:10.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (25, N'法国XO1皇家至尊', 26, 900.0000, 780.0000, N'<p>法国XO皇家至尊</p>', CAST(N'2019-08-03T07:46:21.000' AS DateTime), 5)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (26, N'2021新款时髦裙子', 10, 109.0000, 69.5000, N'<p>2019新款时髦套装裙子</p>', CAST(N'2019-08-03T07:34:37.000' AS DateTime), 50)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (27, N'2021新款苹果笔记本', 15, 8999.0000, 8950.0000, N'<p>2019新款苹果笔记本电脑</p>', CAST(N'2019-08-03T07:41:10.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (28, N'法国XO2皇家至尊', 23, 900.0000, 780.0000, N'<p>法国XO皇家至尊</p>', CAST(N'2019-08-03T07:46:21.000' AS DateTime), 5)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (29, N'2022新款时髦裙子', 12, 109.0000, 69.5000, N'<p>2019新款时髦套装裙子</p>', CAST(N'2019-08-03T07:34:37.000' AS DateTime), 50)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (30, N'2022新款苹果笔记本', 16, 8999.0000, 8950.0000, N'<p>2019新款苹果笔记本电脑</p>', CAST(N'2019-08-03T07:41:10.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (31, N'法国XO3皇家至尊', 22, 900.0000, 780.0000, N'<p>法国XO皇家至尊</p>', CAST(N'2019-08-03T07:46:21.000' AS DateTime), 5)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (32, N'2022新款时髦裙子', 9, 109.0000, 69.5000, N'<p>2019新款时髦套装裙子</p>', CAST(N'2019-08-03T07:34:37.000' AS DateTime), 50)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (33, N'2022新款苹果笔记本', 17, 8999.0000, 8950.0000, N'<p>2019新款苹果笔记本电脑</p>', CAST(N'2019-08-03T07:41:10.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (34, N'法国XO3皇家至尊', 22, 900.0000, 780.0000, N'<p>法国XO皇家至尊</p>', CAST(N'2019-08-03T07:46:21.000' AS DateTime), 5)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (35, N'2022新款时髦裙子', 8, 109.0000, 69.5000, N'<p>2019新款时髦套装裙子</p>', CAST(N'2019-08-03T07:34:37.000' AS DateTime), 50)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (36, N'2022新款苹果笔记本', 18, 8999.0000, 8950.0000, N'<p>2019新款苹果笔记本电脑</p>', CAST(N'2019-08-03T07:41:10.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (37, N'法国XO3皇家至尊', 23, 900.0000, 780.0000, N'<p>法国XO皇家至尊</p>', CAST(N'2019-08-03T07:46:21.000' AS DateTime), 5)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (38, N'2022新款时髦裙子', 10, 109.0000, 69.5000, N'<p>2019新款时髦套装裙子</p>', CAST(N'2019-08-03T07:34:37.000' AS DateTime), 50)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (39, N'2022新款苹果笔记本', 19, 8999.0000, 8950.0000, N'<p>2019新款苹果笔记本电脑</p>', CAST(N'2019-08-03T07:41:10.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (40, N'法国XO3皇家至尊', 24, 900.0000, 780.0000, N'<p>法国XO皇家至尊</p>', CAST(N'2019-08-03T07:46:21.000' AS DateTime), 5)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (41, N'2022新款时髦裙子', 11, 109.0000, 69.5000, N'<p>2019新款时髦套装裙子</p>', CAST(N'2019-08-03T07:34:37.000' AS DateTime), 50)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (42, N'2022新款苹果笔记本', 20, 8999.0000, 8950.0000, N'<p>2019新款苹果笔记本电脑</p>', CAST(N'2019-08-03T07:41:10.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (43, N'法国XO3皇家至尊', 21, 900.0000, 780.0000, N'<p>法国XO皇家至尊</p>', CAST(N'2019-08-03T07:46:21.000' AS DateTime), 5)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (44, N'2022新款时髦裙子', 12, 109.0000, 69.5000, N'<p>2019新款时髦套装裙子</p>', CAST(N'2019-08-03T07:34:37.000' AS DateTime), 50)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (45, N'2022新款苹果笔记本', 15, 8999.0000, 8950.0000, N'<p>2019新款苹果笔记本电脑</p>', CAST(N'2019-08-03T07:41:10.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (46, N'法国XO3皇家至尊', 26, 900.0000, 780.0000, N'<p>法国XO皇家至尊</p>', CAST(N'2019-08-03T07:46:21.000' AS DateTime), 5)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (47, N'2022新款时髦裙子', 11, 109.0000, 69.5000, N'<p>2019新款时髦套装裙子</p>', CAST(N'2019-08-03T07:34:37.000' AS DateTime), 50)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (48, N'2022新款苹果笔记本', 16, 8999.0000, 8950.0000, N'<p>2019新款苹果笔记本电脑</p>', CAST(N'2019-08-03T07:41:10.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (49, N'法国XO3皇家至尊', 25, 900.0000, 780.0000, N'<p>法国XO皇家至尊</p>', CAST(N'2019-08-03T07:46:21.000' AS DateTime), 5)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (50, N'2022新款时髦裙子', 12, 109.0000, 69.5000, N'<p>2019新款时髦套装裙子</p>', CAST(N'2019-08-03T07:34:37.000' AS DateTime), 50)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (51, N'2022新款苹果笔记本', 17, 8999.0000, 8950.0000, N'<p>2019新款苹果笔记本电脑</p>', CAST(N'2019-08-03T07:41:10.000' AS DateTime), 2)
INSERT [dbo].[Product] ([ProductId], [Title], [CategoryId], [MarketPrice], [Price], [Content], [PostTime], [Stock]) VALUES (52, N'法国XO3皇家至尊', 24, 900.0000, 780.0000, N'<p>法国XO皇家至尊</p>', CAST(N'2019-08-03T07:46:21.000' AS DateTime), 5)
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UsersId], [UserName], [Pwd], [Email], [Nick], [DeliveryId]) VALUES (1, N'yinq', N'e10adc3949ba59abbe56e057f20f883e', N'yinq@qq.com', N'小强', 2)
INSERT [dbo].[Users] ([UsersId], [UserName], [Pwd], [Email], [Nick], [DeliveryId]) VALUES (3, N'taotao', N'e10adc3949ba59abbe56e057f20f883e', N'taotao@qq.com', N'涛涛', NULL)
INSERT [dbo].[Users] ([UsersId], [UserName], [Pwd], [Email], [Nick], [DeliveryId]) VALUES (4, N'xiongxiong', N'e10adc3949ba59abbe56e057f20f883e', N'xiongxiong@qq.com', N'雄哥', NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__C9F284568CECC44A]    Script Date: 2020/1/22 21:55:29 ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AdminUser] ADD  DEFAULT ((0)) FOR [role]
GO
ALTER TABLE [dbo].[Appraise] ADD  DEFAULT (getdate()) FOR [RateTime]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF__Orders__Orderdat__48CFD27E]  DEFAULT (getdate()) FOR [Orderdate]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF__Orders__States__4BAC3F29]  DEFAULT ((0)) FOR [States]
GO
ALTER TABLE [dbo].[OrdersDetail] ADD  CONSTRAINT [DF__OrdersDet__State__4F7CD00D]  DEFAULT ((0)) FOR [States]
GO
ALTER TABLE [dbo].[Product] ADD  DEFAULT (getdate()) FOR [PostTime]
GO
ALTER TABLE [dbo].[Appraise]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[Appraise]  WITH CHECK ADD FOREIGN KEY([UsersId])
REFERENCES [dbo].[Users] ([UsersId])
GO
ALTER TABLE [dbo].[Car]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[Car]  WITH CHECK ADD FOREIGN KEY([UsersId])
REFERENCES [dbo].[Users] ([UsersId])
GO
ALTER TABLE [dbo].[Category]  WITH CHECK ADD FOREIGN KEY([ParentId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Delivery]  WITH CHECK ADD  CONSTRAINT [FK_Delivery_UsersId] FOREIGN KEY([UsersId])
REFERENCES [dbo].[Users] ([UsersId])
GO
ALTER TABLE [dbo].[Delivery] CHECK CONSTRAINT [FK_Delivery_UsersId]
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[Favorite]  WITH CHECK ADD FOREIGN KEY([UsersId])
REFERENCES [dbo].[Users] ([UsersId])
GO
ALTER TABLE [dbo].[OrdersDetail]  WITH CHECK ADD  CONSTRAINT [FK__OrdersDet__Order__4F7CD00D] FOREIGN KEY([OrdersId])
REFERENCES [dbo].[Orders] ([OrdersId])
GO
ALTER TABLE [dbo].[OrdersDetail] CHECK CONSTRAINT [FK__OrdersDet__Order__4F7CD00D]
GO
ALTER TABLE [dbo].[OrdersDetail]  WITH CHECK ADD  CONSTRAINT [FK__OrdersDet__Produ__5812160E] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[OrdersDetail] CHECK CONSTRAINT [FK__OrdersDet__Produ__5812160E]
GO
ALTER TABLE [dbo].[Photo]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([ProductId])
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[AdminUser]  WITH CHECK ADD CHECK  (([role]=(0) OR [role]=(1)))
GO
ALTER TABLE [dbo].[Appraise]  WITH CHECK ADD CHECK  (([Grade]=(0) OR [Grade]=(1) OR [Grade]=(2)))
GO
ALTER TABLE [dbo].[News]  WITH CHECK ADD CHECK  (([States]=(0) OR [States]=(1)))
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [CK__Orders__States__4CA06362] CHECK  (([States]=(0) OR [States]=(1) OR [States]=(2) OR [States]=(3) OR [States]=(4)))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [CK__Orders__States__4CA06362]
GO
ALTER TABLE [dbo].[OrdersDetail]  WITH CHECK ADD  CONSTRAINT [CK__OrdersDet__State__5FB337D6] CHECK  (([States]=(0) OR [States]=(1) OR [States]=(2)))
GO
ALTER TABLE [dbo].[OrdersDetail] CHECK CONSTRAINT [CK__OrdersDet__State__5FB337D6]
GO
USE [master]
GO
ALTER DATABASE [ChangeDB] SET  READ_WRITE 
GO
