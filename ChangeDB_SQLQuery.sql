use master
go
create database ChangeDB
go
 use ChangeDB
 go

create table AdminUser	--����Ա��
(
AdminUserId	int primary key identity(1,1),
UserName	nvarchar(50) NOT NULL,
Pwd	nvarchar(50) NOT NULL,
AUrole	int  NOT NULL default 0 check(AUrole=0 or AUrole=1)

)

go

create table Category	--��Ʒ����
(
CategoryId	int primary key identity(1,1),
CateName	nvarchar(50) NOT NULL,
ParentId	int foreign key references Category(CategoryId)  --�ϼ������(���)

)

go

create table Product	--��Ʒ��
(
ProductId	int primary key identity(1,1),
Title	nvarchar(100) NOT NULL,
CateId	int NOT NULL foreign key references Category(CategoryId),	--������(���)
MarketPrice	money NOT NULL,
Price	money NOT NULL,
Content	nvarchar(max),
PostTime	datetime default Getdate(),
Stock	int  NOT NULL

)

go

create table Delivery	--�ջ���ַ��
(
DeliveryId	int primary key identity(1,1),
UsersId	int  NOT NULL, --foreign key references Users(UserId),		--�û����(���)
Consignee	nvarchar(50)  NOT NULL,
Complete	nvarchar(200)  NOT NULL,
Phone	nvarchar(12)  NOT NULL

)

go

create table Users	--�û���
(
UsersId	int primary key identity(1,1),
UserName	nvarchar(50) NOT NULL unique,
Pwd	nvarchar(50) NOT NULL,
Email	nvarchar(50) NOT NULL,
Nick	nvarchar(50),
DeliveryID	int	foreign key references Delivery(DeliveryID)	--Ĭ���ջ���ַ���(���)

)

go

--Ϊ�ջ���ַ��Delivery�û�����ֶ�UsersId������Users(UserId)
alter table Delivery add  constraint FK_Delivery_UsersId foreign key (UsersId)  references Users(UsersId);

go

create table Appraise	--��Ʒ���۱�
(
AppraiseId	int primary key identity(1,1),
UsersId	int  NOT NULL foreign key references Users(UsersId),		--�û����(���)
ProductId	int  NOT NULL foreign key references Product(ProductId),	--��Ʒ���(���)
Content	nvarchar(max)  NOT NULL,
Grade	int  NOT NULL check(Grade=0 or Grade=1 or Grade=2),
RateTime	datetime default Getdate()
)

go

create table Favorite	--�ղؼб�
(
FavoriteId	int primary key identity(1,1),
ProductId	int	 NOT NULL foreign key references Product(ProductId),		--��Ʒ���(���)
UsersId	int	 NOT NULL foreign key references Users(UsersId),			--�û����(���)
)

go

create table News	--������Ѷ��
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

create table Orders		--������
(
OrdersId	int primary key identity(1,1),
Orderdate	date  default Getdate(),
UsersId	int  NOT NULL foreign key references Users(UsersId),			--�û����(���)
Total	money,
DeliveryId	int foreign key references Delivery(DeliveryId),			--�û��ջ���ַ���(���)
DeliveryDate	date,
States	int default 0 check(States=0 or States=1 or States=2 or States=3 or  States=4),
Remark	nvarchar(500)
)

go

create table OrdersDetail	--���������
(
OrdersDetailId	int primary key identity(1,1),
OrdersId	int NOT NULL foreign key references Orders(OrdersID),		--�������(���)
ProductId	int NOT NULL foreign key references Product(ProductId),		--��Ʒ���(���)
Quantity	int NOT NULL,
States	int default 0 check(States=0 or States=1 or States=2 )
)

go

create table Photo	--��ƷͼƬ��
(
PhotoId	int primary key identity(1,1),
ProductId	int NOT NULL foreign key references Product(ProductId),		--��Ʒ���(���)
PhotoUrl	nvarchar(200)
)

go


