-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th12 13, 2021 lúc 04:09 AM
-- Phiên bản máy phục vụ: 10.4.19-MariaDB
-- Phiên bản PHP: 8.0.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `ecommerce_db`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `banners`
--

CREATE TABLE `banners` (
  `id` int(11) NOT NULL,
  `caption` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `link` varchar(100) NOT NULL,
  `created` date NOT NULL,
  `creater_id` int(11) NOT NULL,
  `updated` date DEFAULT NULL,
  `updater_id` int(11) DEFAULT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `banners`
--

INSERT INTO `banners` (`id`, `caption`, `description`, `link`, `created`, `creater_id`, `updated`, `updater_id`, `status`) VALUES
(2, 'banner 1', 'des 1', 'http://localhost:9595/manager/banner/save', '2021-11-01', 1, '2021-12-02', 1, 0),
(3, 'banner 2', 'des 1', 'link 1', '2021-11-01', 1, NULL, NULL, 0),
(4, 'banner 3', 'des 1', 'link 1', '2021-11-29', 1, NULL, NULL, 0),
(5, 'banner 4', 'asdf', 'dddd', '2021-11-29', 1, NULL, NULL, 0),
(12, 'There are many new laptop models', 'very cheap price', 'https://adminlte.io/docs/3.1//javascript/toasts.html', '2021-12-01', 1, '2021-12-08', 1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `branchs`
--

CREATE TABLE `branchs` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `logo` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `branchs`
--

INSERT INTO `branchs` (`id`, `name`, `logo`) VALUES
(1, 'Dellxx', 'e37fd860db1b453caf0e4d20e321391c.png'),
(2, 'Apple', 'thumb1.gif'),
(3, 'Acer', 'thumb1.gif'),
(4, 'Samsung', 'thumb1.gif'),
(5, 'eidteeasddd', '16c60c2957f04dabbd671fff6067e083.png');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `carts`
--

CREATE TABLE `carts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` date NOT NULL,
  `status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `carts`
--

INSERT INTO `carts` (`id`, `user_id`, `created`, `status`) VALUES
(25, 10, '2021-12-06', 'done'),
(26, 10, '2021-12-06', 'done'),
(27, 10, '2021-12-06', 'done'),
(29, 10, '2021-12-06', 'done'),
(31, 10, '2021-12-06', 'done'),
(57, 10, '2021-12-07', 'pending'),
(58, 10, '2021-12-07', 'done'),
(59, 10, '2021-12-07', 'pending'),
(60, 10, '2021-12-08', 'done'),
(61, 10, '2021-12-08', 'pending'),
(62, 1, '2021-12-08', 'pending'),
(63, 12, '2021-12-08', 'pending'),
(64, 12, '2021-12-08', 'pending'),
(65, 12, '2021-12-08', 'pending'),
(66, 12, '2021-12-08', 'pending'),
(67, 1, '2021-12-08', 'pending'),
(68, 1, '2021-12-08', 'pending'),
(69, 1, '2021-12-08', 'pending'),
(70, 1, '2021-12-08', 'pending'),
(71, 1, '2021-12-08', 'pending'),
(72, 1, '2021-12-08', 'pending'),
(73, 1, '2021-12-08', 'pending'),
(74, 14, '2021-12-08', 'done'),
(75, 14, '2021-12-08', 'done'),
(76, 14, '2021-12-08', 'pending');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart_product`
--

CREATE TABLE `cart_product` (
  `id` int(11) NOT NULL,
  `cart_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `cart_product`
--

INSERT INTO `cart_product` (`id`, `cart_id`, `product_id`, `quantity`) VALUES
(83, 25, 5, 1),
(84, 26, 7, 1),
(85, 27, 3, 1),
(86, 29, 14, 1),
(87, 31, 12, 1),
(98, 58, 7, 1),
(100, 60, 7, 6),
(101, 62, 16, 1),
(102, 72, 5, 1),
(103, 72, 3, 1),
(104, 72, 7, 1),
(105, 74, 2, 1),
(106, 74, 3, 1),
(107, 75, 5, 1),
(108, 75, 7, 1),
(109, 75, 12, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `discount_percent` double NOT NULL,
  `status` tinyint(1) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `level` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`, `discount_percent`, `status`, `parent_id`, `level`) VALUES
(1, 'Laptop MSI', 5, 1, NULL, 1),
(2, 'Laptop MSI i7 8800H', 0, 1, 1, 2),
(3, 'Laptop Lenovo', 15, 1, NULL, 1),
(4, 'Laptop Lenovo Black I7', 0, 1, 3, 2),
(5, 'Laptop Acer', 15, 1, NULL, 1),
(6, 'Laptop Acer I7', 15, 1, 5, 2),
(12, 'Laptop Asus', 15, 1, 13, 1),
(13, 'Laptop Asus I5', 15, 1, 12, 2),
(14, 'Laptop Asus Pink', 15, 1, 13, 3),
(15, 'Laptop MSI I5', 15, 1, 1, 2),
(16, 'Laptop Acer Yellow', 15, 1, 6, 3),
(17, 'Laptop MSI Pink', 15, 1, 15, 3),
(18, 'Laptop MSI Blue', 15, 1, 2, 3),
(19, 'Laptop MSI Black', 15, 1, 15, 3),
(20, 'Laptop Asus Black', 15, 1, 13, 3),
(21, 'Laptop Acer FT', 15, 1, 6, 3),
(22, 'Laptop Asus Black', 15, 1, 13, 3),
(23, 'Laptop Acer Pink', 15, 1, 6, 3);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chat_chanels`
--

CREATE TABLE `chat_chanels` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `store_id` int(11) NOT NULL,
  `isUser_sender` tinyint(1) NOT NULL,
  `time_sent` date NOT NULL,
  `content` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `content` varchar(500) NOT NULL,
  `rating` int(11) NOT NULL,
  `created` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `address` varchar(200) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `phone`, `address`, `status`) VALUES
(1, 'Contact name', 'abc@gmail.com', '01234568874', 'address', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `content` varchar(300) NOT NULL,
  `created` date NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `feedback`
--

INSERT INTO `feedback` (`id`, `user_id`, `content`, `created`, `status`) VALUES
(1, 1, 'content 1', '2021-11-01', 1),
(2, 1, 'content 2', '2021-11-01', 0),
(3, 1, 'content 3', '2021-11-01', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `banner_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `images`
--

INSERT INTO `images` (`id`, `name`, `product_id`, `banner_id`) VALUES
(3, 'thumb1.gif', NULL, 3),
(4, 'thumb2.gif', NULL, 3),
(8, 'dc297ea1730342c983ea01ef252e93f1.png', NULL, 4),
(9, 'c7b132b0dc534d06b12d422e55dab05f.png', NULL, 4),
(12, 'fe218129e4f74864a94d15e0c9054a12.png', NULL, 2),
(30, 'banner2.jpg', NULL, 12),
(31, 'banner1.png', NULL, 12);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `content` varchar(200) NOT NULL,
  `created` date NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `is_all_user` tinyint(1) NOT NULL DEFAULT 0,
  `is_all_store` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `store_id`, `content`, `created`, `is_read`, `is_all_user`, `is_all_store`) VALUES
(6, 3, NULL, 'adfasdfasdfeeee', '2021-11-25', 0, 0, 0),
(7, NULL, NULL, 'new notification for all user', '2021-11-25', 0, 1, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `avatar` varchar(100) NOT NULL,
  `description` varchar(500) NOT NULL,
  `description_detail` text NOT NULL,
  `original_price` double NOT NULL,
  `sale_off_percent` double DEFAULT 0,
  `price` double NOT NULL,
  `quantity` int(11) NOT NULL,
  `inventory` int(11) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created` date NOT NULL,
  `updated` date DEFAULT NULL,
  `is_outstanding` tinyint(1) DEFAULT 0,
  `is_best_selling` tinyint(1) DEFAULT 0,
  `is_new` tinyint(1) DEFAULT 0,
  `store_id` int(1) NOT NULL,
  `discount_percent` double NOT NULL,
  `discount_amount` double NOT NULL,
  `rating_count` int(11) NOT NULL,
  `rating_average` double NOT NULL,
  `status` tinyint(1) NOT NULL,
  `ban_reason` text DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `name`, `avatar`, `description`, `description_detail`, `original_price`, `sale_off_percent`, `price`, `quantity`, `inventory`, `branch_id`, `category_id`, `created`, `updated`, `is_outstanding`, `is_best_selling`, `is_new`, `store_id`, `discount_percent`, `discount_amount`, `rating_count`, `rating_average`, `status`, `ban_reason`, `is_locked`) VALUES
(1, 'Laptop Aspire Black', 'aspire1.jpg', 'Laptop 1 description', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 100, 0, 100, 12, 12, 2, 18, '2021-11-18', '2021-12-08', 0, 0, 1, 1, 25, 25, 2, 4, 1, NULL, 0),
(2, 'Laptop Aspire Red', 'aspire2.jpg', 'Product 2 description', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.\r\n', 100, 0, 70, 11, 12, 5, 18, '2021-11-18', '2021-11-19', 0, 1, 1, 1, 25, 25, 1, 5, 1, 'true', 0),
(3, 'Laptop ASPIRE', 'aspire4.jpg', 'fffttttt', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 100, 0, 55, 10, 12, 1, 18, '2021-11-18', '2021-11-30', 1, 0, 1, 1, 25, 25, 3, 4, 1, NULL, 0),
(4, 'Product 4', 'hp.jpg', 'Product 4 description', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 100, 0, 40, 12, 12, 1, 18, '2021-11-18', '2021-11-27', 0, 0, 1, 1, 25, 25, 3, 3, 1, '', 0),
(5, 'Laptop Asprice', 'aspire2.jpg', 'Product 5 description', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 100, 0, 80, 10, 12, 1, 18, '2021-11-01', '2021-11-18', 1, 0, 1, 1, 25, 25, 2, 1, 1, '', 0),
(7, 'Laptop MSI', 'msige2.jpg', 'Product 6 description', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 100, 0, 25, 1, 12, 1, 18, '2021-11-18', '2021-12-08', 1, 0, 1, 1, 25, 25, 1, 5, 1, NULL, 0),
(10, 'Laptop MSI GE', 'msige3.jpg', 'Laptop 2 description', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 100, 0, 60, 12, 12, 2, 18, '2021-11-18', '2021-12-08', 0, 0, 1, 1, 25, 25, 2, 4, 1, NULL, 0),
(11, 'Laptop MSI', 'msige4.jpg', '', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 100, 0, 70, 12, 12, 5, 18, '2021-11-18', '2021-11-19', 0, 1, 1, 1, 25, 25, 1, 5, 1, 'true', 0),
(12, 'Laptop Yoga', 'yoga2.jpg', 'fffttttt', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 100, 0, 55, 10, 12, 1, 18, '2021-11-18', '2021-11-30', 1, 0, 1, 1, 25, 25, 3, 4, 1, NULL, 0),
(13, 'Laptop Lenovo', 'dell.jpg', 'Product 11 description', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 100, 0, 40, 12, 12, 1, 18, '2021-11-18', '2021-11-27', 0, 0, 1, 1, 25, 25, 3, 3, 1, '', 0),
(14, 'Laptop MSI ', 'msipule3.jpg', 'Product 9 description', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 100, 0, 80, 11, 12, 1, 18, '2021-11-01', '2021-11-18', 1, 0, 1, 1, 25, 25, 2, 1, 1, '', 0),
(15, 'Laptop MSI Pule', 'msipule4.jpg', 'Product 10 description', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 100, 0, 25, 12, 12, 1, 18, '2021-11-18', '2021-11-18', 1, 0, 1, 1, 25, 25, 1, 5, 1, '', 0),
(16, 'Laptop Nitro', 'nitro2.jpg', 'Laptop asus detail', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 15, 0, 15, 0, 0, 1, 1, '2021-12-07', '2021-12-07', 0, 0, 1, 1, 0, 0, 0, 0, 1, NULL, NULL),
(17, 'Laptop Nitro', 'nitro1.jpg', 'asdfasdfasdfas', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 50, 0, 50, 0, 0, 1, 1, '2021-12-08', NULL, 0, 0, 1, 1, 0, 0, 0, 0, 1, NULL, NULL),
(18, 'Laptop Lenovo', '8cd8619370094e4897d5a3437a3def00.jpg', 'Laptop Asus', 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation.', 12.3, 0, 23.5, 0, 0, 1, 5, '2021-12-08', NULL, 1, 1, 1, 1, 0, 0, 0, 0, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `name`, `status`) VALUES
(1, 'ROLE_USER', 1),
(2, 'ROLE_ADMIN', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `services`
--

CREATE TABLE `services` (
  `id` int(11) NOT NULL,
  `name` varchar(200) NOT NULL,
  `description` varchar(500) NOT NULL,
  `original_price` double NOT NULL,
  `price` double NOT NULL,
  `duration` int(11) NOT NULL,
  `created` date NOT NULL,
  `created_id` int(11) NOT NULL,
  `updated` date DEFAULT NULL,
  `updated_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `services`
--

INSERT INTO `services` (`id`, `name`, `description`, `original_price`, `price`, `duration`, `created`, `created_id`, `updated`, `updated_id`) VALUES
(1, 'service 1', 'description 1', 1000, 1000, 5, '2021-11-01', 1, NULL, NULL),
(2, 'service 2', 'description 2', 1500, 1400, 10, '2021-11-01', 1, NULL, NULL),
(3, 'service 3', 'description 3', 2500, 2000, 15, '2021-11-01', 1, NULL, NULL),
(5, 'service 4', 'description 4', 999, 1111, 2, '2021-11-29', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `stores`
--

CREATE TABLE `stores` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `address` varchar(500) NOT NULL,
  `logo` varchar(200) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` date NOT NULL,
  `expiry` date DEFAULT NULL,
  `updated` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `ban_term` date DEFAULT NULL,
  `paypal_account` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `stores`
--

INSERT INTO `stores` (`id`, `name`, `phone`, `email`, `address`, `logo`, `user_id`, `created`, `expiry`, `updated`, `status`, `ban_term`, `paypal_account`) VALUES
(1, 'Store x', '0347557353', 'hoangbichht@gmail.com', '4/1 street 10, Thu Duc City', 'logo2.jpg', 5, '2021-11-18', '2021-11-30', '2021-12-08', 1, NULL, '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `store_services`
--

CREATE TABLE `store_services` (
  `store_id` int(11) NOT NULL,
  `service_id` int(11) NOT NULL,
  `created` date NOT NULL,
  `duration` int(11) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `system`
--

CREATE TABLE `system` (
  `id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `banner_img_amount` int(11) NOT NULL,
  `max_banner_photo_size` int(11) NOT NULL,
  `default_ban_email_content` text NOT NULL,
  `default_ban_email_subject` varchar(200) NOT NULL,
  `default_password_email_content` text NOT NULL,
  `default_password_email_subject` text NOT NULL,
  `paypal_account` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `email_password` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `system`
--

INSERT INTO `system` (`id`, `title`, `banner_img_amount`, `max_banner_photo_size`, `default_ban_email_content`, `default_ban_email_subject`, `default_password_email_content`, `default_password_email_subject`, `paypal_account`, `email`, `email_password`) VALUES
(1, 'One Vendor', 5, 2, '<b>Default ban email content</b>', 'Default ban email subject', '<b>Default password email content</b> :', 'Default password email subject', 'sb-89nsw5547823@business.example.com', 'testsemester4@gmail.com', 'TestSemester4@1234');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tags`
--

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `tags`
--

INSERT INTO `tags` (`id`, `name`, `status`) VALUES
(1, 'tag 1', 1),
(2, 'tag 2', 1),
(3, 'tag 3', 1),
(4, 'tag 4', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tag_products`
--

CREATE TABLE `tag_products` (
  `id` int(11) NOT NULL,
  `tag_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `price` double NOT NULL,
  `service_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT 1,
  `quantity` int(11) NOT NULL,
  `tax` double DEFAULT 0,
  `total` double NOT NULL,
  `note` varchar(500) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `transaction_detail_id` int(11) NOT NULL,
  `status` varchar(50) NOT NULL,
  `cancel_reason` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `transactions`
--

INSERT INTO `transactions` (`id`, `price`, `service_id`, `store_id`, `quantity`, `tax`, `total`, `note`, `product_id`, `transaction_detail_id`, `status`, `cancel_reason`) VALUES
(7, 500, NULL, 1, 1, 100, 600, NULL, 1, 1, 'cancel', 'Cancelled by store - I don\'t like this transaction'),
(8, 600, NULL, 1, 1, 100, 700, NULL, 5, 1, 'done', ''),
(9, 500, NULL, 1, 1, 100, 600, NULL, 2, 1, 'cancel', NULL),
(10, 600, NULL, 1, 1, 100, 700, NULL, 1, 1, 'done', NULL),
(11, 600, NULL, 1, 1, 100, 700, NULL, 5, 1, 'done', NULL),
(12, 500, NULL, 1, 1, 100, 600, NULL, 3, 1, 'done', NULL),
(13, 25, NULL, 1, 1, 0, 25, NULL, 7, 7, 'pending', NULL),
(14, 80, NULL, 1, 1, 0, 80, NULL, 5, 8, 'pending', NULL),
(15, 25, NULL, 1, 1, 0, 25, NULL, 7, 9, 'pending', NULL),
(16, 55, NULL, 1, 1, 0, 55, NULL, 3, 10, 'pending', NULL),
(17, 80, NULL, 1, 1, 0, 80, NULL, 14, 11, 'pending', NULL),
(18, 55, NULL, 1, 1, 0, 55, NULL, 12, 12, 'pending', NULL),
(19, 25, NULL, 1, 1, 0, 25, NULL, 7, 13, 'pending', NULL),
(20, 25, NULL, 1, 6, 0, 150, NULL, 7, 14, 'pending', NULL),
(21, 70, NULL, 1, 1, 0, 70, NULL, 2, 15, 'pending', NULL),
(22, 55, NULL, 1, 1, 0, 55, NULL, 3, 15, 'pending', NULL),
(23, 80, NULL, 1, 1, 0, 80, NULL, 5, 16, 'pending', NULL),
(24, 25, NULL, 1, 1, 0, 25, NULL, 7, 16, 'pending', NULL),
(25, 55, NULL, 1, 1, 0, 55, NULL, 12, 16, 'pending', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `transaction_details`
--

CREATE TABLE `transaction_details` (
  `id` int(11) NOT NULL,
  `name` varchar(200) DEFAULT 'Transaciton details',
  `payment` varchar(100) DEFAULT 'paypal',
  `address` varchar(500) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `discount` double DEFAULT 0,
  `vat` double DEFAULT 0,
  `created` date NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `transaction_details`
--

INSERT INTO `transaction_details` (`id`, `name`, `payment`, `address`, `quantity`, `discount`, `vat`, `created`, `user_id`) VALUES
(1, 'transaction detail 1', 'paypal', 'address 1', 2, 0, 0, '2021-11-01', 3),
(2, 'Transaction details Mon Dec 06 18:30:39 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-06', 10),
(3, 'Transaction details Mon Dec 06 18:31:16 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-06', 10),
(4, 'Transaction details Mon Dec 06 18:33:27 ICT 2021', NULL, 'tmp address', 2, 0, 0, '2021-12-06', 10),
(5, 'Transaction details Mon Dec 06 18:36:08 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-06', 10),
(6, 'Transaction details Mon Dec 06 18:40:56 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-06', 10),
(7, 'Transaction details Mon Dec 06 18:46:49 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-06', 10),
(8, 'Transaction details Mon Dec 06 18:50:06 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-06', 10),
(9, 'Transaction details Mon Dec 06 18:52:47 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-06', 10),
(10, 'Transaction details Mon Dec 06 18:59:26 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-06', 10),
(11, 'Transaction details Mon Dec 06 19:00:40 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-06', 10),
(12, 'Transaction details Mon Dec 06 19:02:34 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-06', 10),
(13, 'Transaction details Tue Dec 07 19:37:01 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-07', 10),
(14, 'Transaction details Wed Dec 08 09:45:01 ICT 2021', NULL, 'tmp address', 1, 0, 0, '2021-12-08', 10),
(15, 'Transaction details Wed Dec 08 15:22:28 ICT 2021', NULL, 'tmp address', 2, 0, 0, '2021-12-08', 14),
(16, 'Transaction details Wed Dec 08 15:32:56 ICT 2021', NULL, 'tmp address', 3, 0, 0, '2021-12-08', 14);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
  `password` varchar(200) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `birthday` date NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created` date NOT NULL,
  `updated` date DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `role_id` int(11) NOT NULL,
  `ban_term` date DEFAULT NULL,
  `address` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `fullname`, `birthday`, `phone`, `email`, `created`, `updated`, `status`, `role_id`, `ban_term`, `address`) VALUES
(1, 'admin', '$2a$10$P9nDmcsnHlL.SLJ54aRkve3bYuK4NvAjMXRVSvcFkGB.7njNj2KFy', 'admin', '2021-11-10', '123', 'hoangbichht@gmail.com', '2021-11-01', '2021-12-02', 0, 2, NULL, ''),
(3, 'username1Ok', '123', 'user 1', '2001-07-12', '123225544688', 'hoangbichht@gmail.com', '2021-11-01', '2021-12-02', 1, 1, NULL, ''),
(4, 'user2', '123', 'user 2', '2021-11-01', '123', 'hoangbichht@gmail.com', '2021-11-01', '2021-12-01', 0, 1, '2022-01-01', ''),
(5, 'user3', '123', 'user 3', '2021-11-01', '123', 'hoangbichht@gmail.com', '2021-11-01', '2021-12-01', 1, 1, NULL, ''),
(6, 'user4', '123', 'user 4', '2021-11-01', '123', 'hoangbichht@gmail.com', '2021-11-01', '2021-11-27', 1, 1, NULL, ''),
(10, 'usernamey', '$2a$10$x5ZqSEQQha5NNe.ty5RuBOYgSEVGP1cNkwJEXPoAYQ4lxDWnPXWie', 'full name 1', '2001-01-26', '0123456789', 'hoangbichht@gmail.com', '2021-12-03', '2021-12-07', 1, 1, NULL, 'address 10'),
(12, 'usernameU', '$2a$10$hVGUVdJ9H/IwT46FU8lHBOGJHewOhcpuB.jAC73i0X7IuxJLhE1jG', 'fullname y', '2000-12-31', '0123456789', 'hoangbichht@gmail.com', '2021-12-08', NULL, 1, 1, NULL, 'address username y'),
(13, 'Thomtss', '$2a$10$ofCzzY5WbKcl33eM/85QqeNXRdZp6uf4Y9hhjQjKOFj9XaYKPOOOm', 'VuThiThom', '2000-12-31', '0919801182', 'thomvu193@gmail.com', '2021-12-08', NULL, 1, 1, NULL, 'ntannh.vn@gmail.com'),
(14, 'thomvu', '$2a$10$1zjRBttc.o2Zv4iO0QKNO.u3fcu.zgW8uFN5d6cYuT6PFY8qS6Am2', 'VuThiThom', '2000-12-31', '0338477509', 'vuthithom29.vn@gmail.com', '2021-12-08', NULL, 1, 1, NULL, 'thon me linh 1, xa buon triet , huyen lak, tinh daklak'),
(15, 'ssstestobject', '$2a$10$9PA8z9CKPNYzu3.Gk2CQqeECiBaotqOlJxo40od/DQWMf/A55m8oe', 'ddddddddddddddddddddddd', '2000-12-31', '0123456789', 'hoangbichht@gmail.com', '2021-12-10', NULL, 1, 1, NULL, 'sdfasdfaeeeeadsd');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`),
  ADD KEY `creater_id` (`creater_id`),
  ADD KEY `updater_id` (`updater_id`);

--
-- Chỉ mục cho bảng `branchs`
--
ALTER TABLE `branchs`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `cart_product`
--
ALTER TABLE `cart_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Chỉ mục cho bảng `chat_chanels`
--
ALTER TABLE `chat_chanels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Chỉ mục cho bảng `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `author_user_id` (`user_id`,`store_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Chỉ mục cho bảng `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`,`banner_id`),
  ADD KEY `banner_id` (`banner_id`);

--
-- Chỉ mục cho bảng `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`,`store_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `branch_id` (`branch_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_id` (`created_id`,`updated_id`),
  ADD KEY `updated_id` (`updated_id`);

--
-- Chỉ mục cho bảng `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `store_services`
--
ALTER TABLE `store_services`
  ADD KEY `store_id` (`store_id`,`service_id`),
  ADD KEY `store_id_2` (`store_id`,`service_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Chỉ mục cho bảng `system`
--
ALTER TABLE `system`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `tag_products`
--
ALTER TABLE `tag_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tag_id` (`tag_id`,`product_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `service_id` (`service_id`),
  ADD KEY `store_id` (`store_id`),
  ADD KEY `transaction_detail_id` (`transaction_detail_id`);

--
-- Chỉ mục cho bảng `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT cho bảng `branchs`
--
ALTER TABLE `branchs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT cho bảng `cart_product`
--
ALTER TABLE `cart_product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT cho bảng `chat_chanels`
--
ALTER TABLE `chat_chanels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT cho bảng `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `services`
--
ALTER TABLE `services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `stores`
--
ALTER TABLE `stores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT cho bảng `system`
--
ALTER TABLE `system`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `tag_products`
--
ALTER TABLE `tag_products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT cho bảng `transaction_details`
--
ALTER TABLE `transaction_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `banners`
--
ALTER TABLE `banners`
  ADD CONSTRAINT `banners_ibfk_1` FOREIGN KEY (`creater_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `banners_ibfk_2` FOREIGN KEY (`updater_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `cart_product`
--
ALTER TABLE `cart_product`
  ADD CONSTRAINT `cart_product_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `cart_product_ibfk_2` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`);

--
-- Các ràng buộc cho bảng `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`);

--
-- Các ràng buộc cho bảng `chat_chanels`
--
ALTER TABLE `chat_chanels`
  ADD CONSTRAINT `chat_chanels_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `chat_chanels_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);

--
-- Các ràng buộc cho bảng `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD CONSTRAINT `chat_messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `chat_messages_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);

--
-- Các ràng buộc cho bảng `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `comments_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`banner_id`) REFERENCES `banners` (`id`),
  ADD CONSTRAINT `images_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`),
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branchs` (`id`),
  ADD CONSTRAINT `products_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Các ràng buộc cho bảng `services`
--
ALTER TABLE `services`
  ADD CONSTRAINT `services_ibfk_1` FOREIGN KEY (`created_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `services_ibfk_2` FOREIGN KEY (`updated_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `stores`
--
ALTER TABLE `stores`
  ADD CONSTRAINT `stores_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `store_services`
--
ALTER TABLE `store_services`
  ADD CONSTRAINT `store_services_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`),
  ADD CONSTRAINT `store_services_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`);

--
-- Các ràng buộc cho bảng `tag_products`
--
ALTER TABLE `tag_products`
  ADD CONSTRAINT `tag_products_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`),
  ADD CONSTRAINT `tag_products_ibfk_3` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`),
  ADD CONSTRAINT `transactions_ibfk_3` FOREIGN KEY (`store_id`) REFERENCES `stores` (`id`),
  ADD CONSTRAINT `transactions_ibfk_4` FOREIGN KEY (`transaction_detail_id`) REFERENCES `transaction_details` (`id`),
  ADD CONSTRAINT `transactions_ibfk_5` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `transaction_details`
--
ALTER TABLE `transaction_details`
  ADD CONSTRAINT `transaction_details_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
