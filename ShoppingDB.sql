USE [master]
GO
/****** Object:  Database [ShoppingDB]    Script Date: 8/8/2023 1:01:17 PM ******/
CREATE DATABASE [ShoppingDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ShoppingDB', FILENAME = N'D:\Document\Database\Data\ShoppingDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ShoppingDB_log', FILENAME = N'D:\Document\Database\Data\ShoppingDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ShoppingDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ShoppingDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ShoppingDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ShoppingDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ShoppingDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ShoppingDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ShoppingDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ShoppingDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ShoppingDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ShoppingDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ShoppingDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ShoppingDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ShoppingDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ShoppingDB] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ShoppingDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ShoppingDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ShoppingDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ShoppingDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ShoppingDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ShoppingDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ShoppingDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ShoppingDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ShoppingDB] SET  MULTI_USER 
GO
ALTER DATABASE [ShoppingDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ShoppingDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ShoppingDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ShoppingDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ShoppingDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ShoppingDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ShoppingDB', N'ON'
GO
ALTER DATABASE [ShoppingDB] SET QUERY_STORE = OFF
GO
USE [ShoppingDB]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 8/8/2023 1:01:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[user_mail] [varchar](100) NOT NULL,
	[password] [varchar](64) NOT NULL,
	[account_role] [int] NOT NULL,
	[user_name] [nvarchar](50) NOT NULL,
	[user_address] [nvarchar](255) NULL,
	[user_phone] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[user_mail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 8/8/2023 1:01:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[user_mail] [varchar](100) NULL,
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[order_status] [int] NULL,
	[order_date] [date] NOT NULL,
	[order_discount_code] [varchar](8) NULL,
	[order_address] [nvarchar](255) NOT NULL,
	[order_phone] [varchar](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders_detail]    Script Date: 8/8/2023 1:01:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders_detail](
	[order_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[amount_product] [int] NULL,
	[total_price_product] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC,
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 8/8/2023 1:01:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_name] [nvarchar](100) NOT NULL,
	[product_des] [nvarchar](255) NULL,
	[product_price] [float] NOT NULL,
	[product_img_source] [varchar](255) NULL,
	[product_type] [varchar](100) NULL,
	[product_brand] [varchar](100) NULL,
	[product_number] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Account] ([user_mail], [password], [account_role], [user_name], [user_address], [user_phone]) VALUES (N'duongdt@fpt.com.vn', N'123', 1, N'Đinh Tùng Dương', N'Đại học FPT', N'0765870407')
INSERT [dbo].[Account] ([user_mail], [password], [account_role], [user_name], [user_address], [user_phone]) VALUES (N'duynv@fpt.com.vn', N'123', 1, N'Truong Van Tien', N'Ho Chi Minh', N'0329975188')
INSERT [dbo].[Account] ([user_mail], [password], [account_role], [user_name], [user_address], [user_phone]) VALUES (N'namdt@fpt.com.vn', N'123', 1, N'Nguyen Van Nam', N'Ho Chi MInh', N'0329975177')
INSERT [dbo].[Account] ([user_mail], [password], [account_role], [user_name], [user_address], [user_phone]) VALUES (N'namnv@fpt.com.vn', N'123', 1, N'Nguyen Van Nam', N'Đại học FPT', N'0329975188')
INSERT [dbo].[Account] ([user_mail], [password], [account_role], [user_name], [user_address], [user_phone]) VALUES (N'phongdt@fpt.com.vn', N'123', 2, N'Dao Trong Phong', N'Đại học FPT', N'039866726')
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([user_mail], [order_id], [order_status], [order_date], [order_discount_code], [order_address], [order_phone]) VALUES (N'duongdt@fpt.com.vn', 55, 1, CAST(N'2022-12-14' AS Date), NULL, N'Đại học FPT', N'0765870407')
INSERT [dbo].[Orders] ([user_mail], [order_id], [order_status], [order_date], [order_discount_code], [order_address], [order_phone]) VALUES (N'namnv@fpt.com.vn', 56, 1, CAST(N'2022-12-14' AS Date), NULL, N'Đại học FPT', N'0329975188')
INSERT [dbo].[Orders] ([user_mail], [order_id], [order_status], [order_date], [order_discount_code], [order_address], [order_phone]) VALUES (N'duynv@fpt.com.vn', 57, 1, CAST(N'2022-12-14' AS Date), NULL, N'Ho Chi Minh', N'0329975188')
INSERT [dbo].[Orders] ([user_mail], [order_id], [order_status], [order_date], [order_discount_code], [order_address], [order_phone]) VALUES (N'namdt@fpt.com.vn', 58, 1, CAST(N'2022-12-16' AS Date), NULL, N'Ho Chi MInh', N'0329975177')
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
INSERT [dbo].[Orders_detail] ([order_id], [product_id], [amount_product], [total_price_product]) VALUES (55, 1, 1, 43.9900016784668)
INSERT [dbo].[Orders_detail] ([order_id], [product_id], [amount_product], [total_price_product]) VALUES (55, 2, 1, 37.9900016784668)
INSERT [dbo].[Orders_detail] ([order_id], [product_id], [amount_product], [total_price_product]) VALUES (55, 3, 1, 32.9900016784668)
INSERT [dbo].[Orders_detail] ([order_id], [product_id], [amount_product], [total_price_product]) VALUES (55, 4, 1, 27.989999771118164)
INSERT [dbo].[Orders_detail] ([order_id], [product_id], [amount_product], [total_price_product]) VALUES (56, 3, 1, 32.9900016784668)
INSERT [dbo].[Orders_detail] ([order_id], [product_id], [amount_product], [total_price_product]) VALUES (56, 4, 2, 55.979999542236328)
INSERT [dbo].[Orders_detail] ([order_id], [product_id], [amount_product], [total_price_product]) VALUES (56, 8, 1, 16.590000152587891)
INSERT [dbo].[Orders_detail] ([order_id], [product_id], [amount_product], [total_price_product]) VALUES (57, 3, 1, 32.9900016784668)
INSERT [dbo].[Orders_detail] ([order_id], [product_id], [amount_product], [total_price_product]) VALUES (58, 3, 1, 32.9900016784668)
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([product_id], [product_name], [product_des], [product_price], [product_img_source], [product_type], [product_brand], [product_number]) VALUES (1, N'iPhone 11 Pro Max 512GB', N'Screen: 6.5", Super Retina XDR<br>
Operating System: iOS 13<br>
CPU: Apple A13 Bionic 6-core<br>
RAM: 4 GB, ROM: 512 GB<br>
Camera: 3 camera 12 MP, Selfie: 12 MP', 43.99, N'https://cdn.tgdd.vn/Products/Images/42/210654/iphone-11-pro-max-512gb-gold-600x600.jpg', N'cellphone', N'apple', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [product_des], [product_price], [product_img_source], [product_type], [product_brand], [product_number]) VALUES (2, N'iPhone 11 Pro Max 256GB', N'Screen: 6.5", Super Retina XDR<br>
Operating System: iOS 13<br>
CPU: Apple A13 Bionic 6-core<br>
RAM: 4 GB, ROM: 512 GB<br>
Camera: 3 camera 12 MP, Selfie: 12 MP', 37.99, N'https://cdn.tgdd.vn/Products/Images/42/210653/iphone-11-pro-max-256gb-black-600x600.jpg', N'cellphone', N'apple', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [product_des], [product_price], [product_img_source], [product_type], [product_brand], [product_number]) VALUES (3, N'iPhone Xs Max 256GB', N'Screen: 6.5", Super Retina<br>
Operating System: iOS 12<br>
CPU: Apple A12 Bionic 6-core<br>
RAM: 4 GB, ROM: 256 GB<br>
Camera: Main camera-12 MP & Secondary-12 MP, Selfie: 7 MP', 32.99, N'https://cdn.tgdd.vn/Products/Images/42/190322/iphone-xs-max-256gb-white-600x600.jpg', N'cellphone', N'apple', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [product_des], [product_price], [product_img_source], [product_type], [product_brand], [product_number]) VALUES (4, N'iPhone X 256GB', N'Screen: 5.8", Super Retina<br>
Operating System: iOS 12<br>
CPU: Apple A11 Bionic 6-core<br>
RAM: 3 GB, ROM: 256 GB<br>
Camera: Main camera-12 MP & Secondary-12 MP, Selfie: 7 MP', 27.99, N'https://cdn.tgdd.vn/Products/Images/42/190324/iphone-xs-256gb-white-600x600.jpg', N'cellphone', N'apple', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [product_des], [product_price], [product_img_source], [product_type], [product_brand], [product_number]) VALUES (5, N'iPhone Xs 64GB', N'Screen: 5.8", Super Retina<br>
Operating System: iOS 12<br>
CPU: Apple A12 Bionic 6-core<br>
RAM: 4 GB, ROM: 64 GB<br>
Camera: Main camera-12 MP & Secondary-12 MP, Selfie: 7 MP', 24.99, N'https://cdn.tgdd.vn/Products/Images/42/190321/iphone-xs-max-gold-600x600.jpg', N'cellphone', N'apple', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [product_des], [product_price], [product_img_source], [product_type], [product_brand], [product_number]) VALUES (6, N'iPhone Xr 128GB', N'Screen: 6.1", Liquid Retina<br>
Operating System: iOS 12<br>
CPU: Apple A12 Bionic 6-core<br>
RAM: 3 GB, ROM: 128 GB<br>
Camera: 12 MP, Selfie: 7 MP', 17.99, N'https://cdn.tgdd.vn/Products/Images/42/191483/iphone-xr-128gb-red-600x600.jpg', N'cellphone', N'apple', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [product_des], [product_price], [product_img_source], [product_type], [product_brand], [product_number]) VALUES (7, N'iPhone Xr 128GB', N'Screen: 6.1", Liquid Retina<br>
Operating System: iOS 12<br>
CPU: Apple A12 Bionic 6-core<br>
RAM: 3 GB, ROM: 128 GB<br>
Camera: 12 MP, Selfie: 7 MP', 17.99, N'https://cdn.tgdd.vn/Products/Images/42/191483/iphone-xr-128gb-red-600x600.jpg', N'cellphone', N'apple', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [product_des], [product_price], [product_img_source], [product_type], [product_brand], [product_number]) VALUES (8, N'iPhone 8 Plus 64GB', N'Screen: 5.5", Retina HD<br>
Operating System: iOS 12<br>
CPU: Apple A11 Bionic 6-core<br>
RAM: 3 GB, ROM: 64 GB<br>
Camera: Main camera-12 MP & Secondary camera-12 MP, Selfie: 7 MP', 16.59, N'https://cdn.tgdd.vn/Products/Images/42/114110/iphone-8-plus-hh-600x600.jpg', N'cellphone', N'apple', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [product_des], [product_price], [product_img_source], [product_type], [product_brand], [product_number]) VALUES (9, N'iPhone 7 Plus 32GB', N'Screen: 5.5", Retina HD<br>
Operating System: iOS 12<br>
CPU: Apple A10 Fusion 4-core 64-bit<br>
RAM: 3 GB, ROM: 32 GB<br>
Camera: Main camera-12 MP & Secondary camera-12 MP, Selfie: 7 MP', 12.49, N'https://cdn.tgdd.vn/Products/Images/42/78124/iphone-7-plus-32gb-gold-600x600.jpg', N'cellphone', N'apple', 50)
INSERT [dbo].[Products] ([product_id], [product_name], [product_des], [product_price], [product_img_source], [product_type], [product_brand], [product_number]) VALUES (10, N'iPhone 7 32GB', N'Screen: 4.7", Retina HD<br>
Operating System: iOS 12<br>
CPU: Apple A10 Fusion 4-core 64-bit<br>
RAM: 3 GB, ROM: 32 GB<br>
Camera: 12 MP, Selfie: 7 MP', 10.49, N'https://cdn.tgdd.vn/Products/Images/42/74110/iphone-7-gold-600x600.jpg', N'cellphone', N'apple', 50)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
ALTER TABLE [dbo].[Orders] ADD  DEFAULT (getdate()) FOR [order_date]
GO
ALTER TABLE [dbo].[Orders_detail]  WITH CHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[Orders_detail]  WITH CHECK ADD FOREIGN KEY([product_id])
REFERENCES [dbo].[Products] ([product_id])
GO
/****** Object:  StoredProcedure [dbo].[GetProducts]    Script Date: 8/8/2023 1:01:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetProducts]
@u int,
@v int
as
begin
 SELECT p.product_id ,p.product_name, p.product_des, p.product_price, p.product_img_source, p.product_type, p.product_brand FROM ( 
  SELECT *, ROW_NUMBER() OVER (ORDER BY product_id) as row 
  FROM Products p
 ) p WHERE p.row >= @u and p.row <= @v
end
GO
/****** Object:  StoredProcedure [dbo].[GetProductsType]    Script Date: 8/8/2023 1:01:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetProductsType]
@u int,
@v int,
@b varchar(50)
as
begin
 SELECT p.product_id ,p.product_name, p.product_des, p.product_price, p.product_img_source, p.product_type, p.product_brand FROM ( 
  SELECT *, ROW_NUMBER() OVER (ORDER BY product_id) as row 
  FROM Products p where p.product_type = @b
 ) p WHERE p.row >= @u and p.row <= @v
end

GO
USE [master]
GO
ALTER DATABASE [ShoppingDB] SET  READ_WRITE 
GO
