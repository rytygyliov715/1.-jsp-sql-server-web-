-- -- 插入Root表的数据
-- INSERT INTO Root_tb (username, password)
-- VALUES ('root1', 'password1'), ('root2', 'password2');
--
-- -- 插入User表的数据
-- INSERT INTO User_tb (username, password, phone_number, email, gender)
-- VALUES ('user1', 'password1', '1234567890', 'user1@example.com', '男'),
--        ('user2', 'password2', '0987654321', 'user2@example.com', '女');
--
-- -- 插入Book表的数据
-- INSERT INTO Book_tb (book_name, author, borrow_status, borrower)
-- VALUES ('Book1', 'Author1', 'available', NULL),
--        ('Book2', 'Author2', 'borrowed', 1);

INSERT INTO User_tb
    (username, password, phone, email, gender)
VALUES
    ('"
+ username + "', '" + password + "', '" + phone + "', '" + email + "', '" + gender + "')