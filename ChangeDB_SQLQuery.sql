use master
go
create database ChangeDB
go
 use ChangeDB
 go

create table AdminUser	--管理员表
(
AdminUserId	int primary key identity(1,1),
UserName	nvarchar(50) NOT NULL,
Pwd	nvarchar(50) NOT NULL,
AUrole	int  NOT NULL default 0 check(AUrole=0 or AUrole=1)

)

go

create table Category	--商品类别表
(
CategoryId	int primary key identity(1,1),
CateName	nvarchar(50) NOT NULL,
ParentId	int foreign key references Category(CategoryId)  --上级类别编号(外键)

)

go

create table Product	--商品表
(
ProductId	int primary key identity(1,1),
Title	nvarchar(100) NOT NULL,
CateId	int NOT NULL foreign key references Category(CategoryId),	--分类编号(外键)
MarketPrice	money NOT NULL,
Price	money NOT NULL,
Content	nvarchar(max),
PostTime	datetime default Getdate(),
Stock	int  NOT NULL

)

go

create table Delivery	--收货地址表
(
DeliveryId	int primary key identity(1,1),
UsersId	int  NOT NULL, --foreign key references Users(UserId),		--用户编号(外键)
Consignee	nvarchar(50)  NOT NULL,
Complete	nvarchar(200)  NOT NULL,
Phone	nvarchar(12)  NOT NULL

)

go

create table Users	--用户表
(
UsersId	int primary key identity(1,1),
UserName	nvarchar(50) NOT NULL unique,
Pwd	nvarchar(50) NOT NULL,
Email	nvarchar(50) NOT NULL,
Nick	nvarchar(50),
DeliveryID	int	foreign key references Delivery(DeliveryID)	--默认收货地址编号(外键)

)

go

--为收货地址表Delivery用户编号字段UsersId添加外键Users(UserId)
alter table Delivery add  constraint FK_Delivery_UsersId foreign key (UsersId)  references Users(UsersId);

go

create table Appraise	--商品评价表
(
AppraiseId	int primary key identity(1,1),
UsersId	int  NOT NULL foreign key references Users(UsersId),		--用户编号(外键)
ProductId	int  NOT NULL foreign key references Product(ProductId),	--商品编号(外键)
Content	nvarchar(max)  NOT NULL,
Grade	int  NOT NULL check(Grade=0 or Grade=1 or Grade=2),
RateTime	datetime default Getdate()
)

go

create table Favorite	--收藏夹表
(
FavoriteId	int primary key identity(1,1),
ProductId	int	 NOT NULL foreign key references Product(ProductId),		--商品编号(外键)
UsersId	int	 NOT NULL foreign key references Users(UsersId),			--用户编号(外键)
)

go

create table News	--促销资讯表
(
NewsId	int primary key identity(1,1),
Title	nvarchar(100)  NOT NULL,
NTypes	nvarchar(10)  NOT NULL,
Content	nvarchar(max)  NOT NULL,
PhotoUrl	nvarchar(200)  NOT NULL,
PushTime	datetime,
States	int check(States=0 or States=1)
)

go

create table Orders		--订单表
(
OrdersId	int primary key identity(1,1),
Orderdate	date  default Getdate(),
UsersId	int  NOT NULL foreign key references Users(UsersId),			--用户编号(外键)
Total	money,
DeliveryId	int foreign key references Delivery(DeliveryId),			--用户收货地址编号(外键)
DeliveryDate	date,
States	int default 0 check(States=0 or States=1 or States=2 or States=3 or  States=4),
Remark	nvarchar(500)
)

go

create table OrdersDetail	--订单详情表
(
OrdersDetailId	int primary key identity(1,1),
OrdersId	int NOT NULL foreign key references Orders(OrdersID),		--订单编号(外键)
ProductId	int NOT NULL foreign key references Product(ProductId),		--商品编号(外键)
Quantity	int NOT NULL,
States	int default 0 check(States=0 or States=1 or States=2 )
)

go

create table Photo	--商品图片表
(
PhotoId	int primary key identity(1,1),
ProductId	int NOT NULL foreign key references Product(ProductId),		--商品编号(外键)
PhotoUrl	nvarchar(200)
)

go


