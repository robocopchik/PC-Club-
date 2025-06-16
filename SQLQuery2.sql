USE ComputerClubDB;
GO

-- Вставляем пользователей
INSERT INTO Users (name, phone, email, balance, registered_at) VALUES
('Иван Иванов', '1234567890', 'ivan@example.com', 1500.00, GETDATE()),
('Мария Петрова', '0987654321', 'maria@example.com', 1200.00, GETDATE()),
('Алексей Смирнов', '1112223333', 'aleksey@example.com', 1000.00, GETDATE()),
('Ольга Кузнецова', '2223334444', 'olga@example.com', 800.00, GETDATE()),
('Дмитрий Васильев', '3334445555', 'dmitry@example.com', 500.00, GETDATE());

-- Вставляем сотрудников
INSERT INTO Employees (name, role, username, password_hash) VALUES
('Администратор', 'Админ', 'admin', HASHBYTES('SHA2_256', 'adminpass')),
('Руководитель', 'Руководитель', 'manager', HASHBYTES('SHA2_256', 'managerpass')),
('Оператор 1', 'Оператор', 'operator1', HASHBYTES('SHA2_256', 'operator1pass')),
('Оператор 2', 'Оператор', 'operator2', HASHBYTES('SHA2_256', 'operator2pass')),
('Оператор 3', 'Оператор', 'operator3', HASHBYTES('SHA2_256', 'operator3pass'));

-- Вставляем залы
INSERT INTO Halls (name, description) VALUES
('Стандарт', 'ПК: Intel i3-12100, NVIDIA RTX 4060, 16GB RAM'),
('ВИП', 'ПК: Intel i7-13700K, NVIDIA RTX 4070, 32GB RAM'),
('Буткемп', 'ПК: Intel i7-13700K, NVIDIA RTX 4070, 32GB RAM');

-- Вставляем тарифы
INSERT INTO Tariffs (name, price_per_hour) VALUES
('Обычный', 170.00),
('ВИП и Буткемп', 220.00),
('Ночной', 500.00);

-- Вставляем связи Hall_Tariffs
INSERT INTO Hall_Tariffs (hall_id, tariff_id) VALUES
(1, 1), -- Стандарт - Обычный
(2, 2), -- ВИП - ВИП и Буткемп
(3, 2), -- Буткемп - ВИП и Буткемп
(1, 3), -- Стандарт - Ночной
(2, 3), -- ВИП - Ночной
(3, 3); -- Буткемп - Ночной

-- Вставляем компьютеры
INSERT INTO Computers (name, specs, status, hall_id, tariff_id) VALUES
('PC-01', 'Intel i3-12100, NVIDIA RTX 4060, 16GB RAM', 'available', 1, 1),
('PC-02', 'Intel i3-12100, NVIDIA RTX 4060, 16GB RAM', 'available', 1, 1),
('PC-03', 'Intel i7-13700K, NVIDIA RTX 4070, 32GB RAM', 'available', 2, 2),
('PC-04', 'Intel i7-13700K, NVIDIA RTX 4070, 32GB RAM', 'available', 2, 2),
('PC-05', 'Intel i7-13700K, NVIDIA RTX 4070, 32GB RAM', 'available', 3, 2);

-- Вставляем сеансы
INSERT INTO Sessions (user_id, computer_id, tariff_id, start_time, end_time, total_price, employee_id) VALUES
(1, 1, 1, DATEADD(hour, -5, GETDATE()), DATEADD(hour, -4, GETDATE()), 170.00, 1),
(2, 2, 1, DATEADD(hour, -3, GETDATE()), DATEADD(hour, -2, GETDATE()), 170.00, 2),
(3, 3, 2, DATEADD(hour, -4, GETDATE()), DATEADD(hour, -3, GETDATE()), 220.00, 3),
(4, 4, 2, DATEADD(hour, -2, GETDATE()), DATEADD(hour, -1, GETDATE()), 220.00, 4),
(5, 5, 2, DATEADD(hour, -6, GETDATE()), DATEADD(hour, -5, GETDATE()), 220.00, 1);

-- Вставляем бронирования
INSERT INTO Bookings (user_id, computer_id, start_time, end_time, status, employee_id) VALUES
(1, 1, DATEADD(hour, 1, GETDATE()), DATEADD(hour, 2, GETDATE()), 'active', 1),
(2, 2, DATEADD(hour, 3, GETDATE()), DATEADD(hour, 4, GETDATE()), 'active', 2),
(3, 3, DATEADD(hour, 5, GETDATE()), DATEADD(hour, 6, GETDATE()), 'cancelled', 3),
(4, 4, DATEADD(hour, 7, GETDATE()), DATEADD(hour, 8, GETDATE()), 'completed', 4),
(5, 5, DATEADD(hour, 9, GETDATE()), DATEADD(hour, 10, GETDATE()), 'active', 1);
