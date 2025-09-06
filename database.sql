-- 1. TẠO BẢNG USERS
CREATE TABLE users (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email_verified_at TIMESTAMP NULL,
    remember_token VARCHAR(100) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. TẠO BẢNG TASKS
CREATE TABLE tasks (
    id BIGSERIAL PRIMARY KEY,
    user_id BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    status BOOLEAN DEFAULT FALSE,
    deadline TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 3. Lưu trữ API tokens để xác thực người dùng trong Laravel Sanctum
CREATE TABLE personal_access_tokens (
    id BIGSERIAL PRIMARY KEY,
    tokenable_type VARCHAR(255) NOT NULL,
    tokenable_id BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    token VARCHAR(64) UNIQUE NOT NULL,
    abilities TEXT,
    last_used_at TIMESTAMP NULL,
    expires_at TIMESTAMP NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);

-- 4. TẠO INDEX ĐỂ TỐI ƯU PERFORMANCE
CREATE INDEX idx_tasks_user_id ON tasks(user_id);
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_tasks_deadline ON tasks(deadline);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index 
ON personal_access_tokens(tokenable_type, tokenable_id);

-- 5. TẠO FUNCTION TỰ ĐỘNG CẬP NHẬT updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- 6. TẠO TRIGGER CHO BẢNG USERS
CREATE TRIGGER update_users_updated_at 
    BEFORE UPDATE ON users 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- 7. TẠO TRIGGER CHO BẢNG TASKS
CREATE TRIGGER update_tasks_updated_at 
    BEFORE UPDATE ON tasks 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();


-- 8. THÊM 2 USER MẪU
-- Password được hash bằng bcrypt cho "password123"
INSERT INTO users (name, email, password, created_at, updated_at) VALUES
('Nguyễn Văn An', 'an@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NOW(), NOW()),
('Trần Thị Bình', 'binh@example.com', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', NOW(), NOW());

-- 9. THÊM 3 TASK CHO MỖI USER
-- Tasks cho user An (user_id = 1)
INSERT INTO tasks (user_id, title, description, status, deadline, created_at, updated_at) VALUES
(1, 'Hoàn thành báo cáo tháng', 'Viết báo cáo tổng kết công việc tháng 8 và gửi cho manager', FALSE, '2025-09-05 17:00:00', NOW(), NOW()),
(1, 'Học Laravel Sanctum', 'Tìm hiểu và thực hành authentication với Laravel Sanctum', TRUE, '2025-08-30 23:59:59', NOW(), NOW()),
(1, 'Mua quà sinh nhật mẹ', 'Đi chợ mua hoa và bánh kem cho sinh nhật mẹ', FALSE, '2025-09-10 12:00:00', NOW(), NOW());

-- Tasks cho user Bình (user_id = 2)
INSERT INTO tasks (user_id, title, description, status, deadline, created_at, updated_at) VALUES
(2, 'Thiết kế UI/UX cho app', 'Tạo mockup và wireframe cho ứng dụng quản lý công việc', FALSE, '2025-09-03 15:00:00', NOW(), NOW()),
(2, 'Đi gym buổi sáng', 'Tập luyện cardio và weight training từ 6h-7h30 sáng', TRUE, '2025-08-31 07:30:00', NOW(), NOW()),
(2, 'Đọc sách "Clean Code"', 'Đọc xong chapter 5-8 về functions và comments', FALSE, '2025-09-07 20:00:00', NOW(), NOW());

-- 10. KIỂM TRA KẾT QUÁ
SELECT 'USERS TABLE' as table_name;
SELECT id, name, email, password, created_at FROM users;

SELECT 'TASKS TABLE' as table_name;
SELECT 
    t.id,
    t.title,
    t.status,
    t.deadline,
    u.name as user_name
FROM tasks t
JOIN users u ON t.user_id = u.id
ORDER BY u.id, t.created_at;

-- 11. THỐNG KÊ
SELECT 
    u.name,
    COUNT(t.id) as total_tasks,
    COUNT(CASE WHEN t.status = TRUE THEN 1 END) as completed_tasks,
    COUNT(CASE WHEN t.status = FALSE THEN 1 END) as pending_tasks
FROM users u
LEFT JOIN tasks t ON u.id = t.user_id
GROUP BY u.id, u.name;




