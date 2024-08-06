-- 创建Root表，存储管理员信息
CREATE TABLE Root_tb (
    root_id INT PRIMARY KEY IDENTITY(1,1),  -- 主键，自增
    username VARCHAR(50),  -- 用户名
    password VARCHAR(50)  -- 密码
);

-- 创建User表，存储用户信息
CREATE TABLE User_tb (
    user_id INT PRIMARY KEY IDENTITY(1,1),  -- 主键，自增
    username VARCHAR(50),  -- 用户名
    password VARCHAR(50),  -- 密码
    phone_number VARCHAR(15),  -- 电话号码
    email VARCHAR(50),  -- 电子邮箱
    gender VARCHAR(10) CHECK (gender IN ('man', 'women'))  -- 性别，只能是'男'或'女'
);

-- 创建Book表，存储图书信息
CREATE TABLE Book_tb (
    book_id INT PRIMARY KEY IDENTITY(1,1),  -- 主键，自增
    book_name VARCHAR(100),  -- 图书名字
    author VARCHAR(50),  -- 作者
    borrow_status VARCHAR(10) CHECK (borrow_status IN ('available', 'borrowed')),  -- 借阅状态，只能是'available'或'borrowed'
    borrower INT,  -- 借阅者的用户编号
    FOREIGN KEY (borrower) REFERENCES User_tb(user_id)  -- 外键，引用User表的user_id
);

-- 插入Root表的数据
INSERT INTO Root_tb (username, password)
VALUES ('root1', 'root01'), ('root2', 'root02');

-- 插入User表的数据
INSERT INTO User_tb (username, password, phone_number, email, gender)
VALUES ('user1', '112233', '1234567890', 'user1@example.com', 'man'),
       ('user2', '111222', '0987654321', 'user2@example.com', 'women');

-- 插入Book表的数据
INSERT INTO Book_tb (book_name, author, borrow_status, borrower)
VALUES ('Book1', 'Author1', 'available', NULL),
       ('Book2', 'Author2', 'available', NULL);