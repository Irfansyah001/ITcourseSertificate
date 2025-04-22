CREATE DATABASE CertificateCourseDB;
GO

USE CertificateCourseDB;
GO

-- =============================================
-- 3. TABEL USERS
-- =============================================
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL,
    FullName VARCHAR(100),
    Email VARCHAR(100)
);

-- =============================================
-- 4. TABEL KURSUS
-- =============================================
CREATE TABLE DataKursus (
    KursusID INT PRIMARY KEY IDENTITY(1,1),
    JudulKursus VARCHAR(100) NOT NULL,
    Deskripsi TEXT
);

-- =============================================
-- 5. TABEL MATERI
-- =============================================
CREATE TABLE Materi (
    MateriID INT PRIMARY KEY IDENTITY(1,1),
    KursusID INT FOREIGN KEY REFERENCES DataKursus(KursusID),
    JudulMateri VARCHAR(100),
    LinkVideo VARCHAR(255),
    Urutan INT,
    DurasiMenit INT
);

-- =============================================
-- 6. TABEL KUIS
-- =============================================
CREATE TABLE Kuis (
    KuisID INT PRIMARY KEY IDENTITY(1,1),
    KursusID INT FOREIGN KEY REFERENCES DataKursus(KursusID),
    Pertanyaan TEXT NOT NULL,
    PilihanA VARCHAR(100),
    PilihanB VARCHAR(100),
    PilihanC VARCHAR(100),
    PilihanD VARCHAR(100),
    JawabanBenar CHAR(1) CHECK (JawabanBenar IN ('A','B','C','D')),
    Poin INT DEFAULT 20
);

-- =============================================
-- 7. TABEL JAWABAN USER
-- =============================================
CREATE TABLE JawabanUser (
    JawabanID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    KuisID INT FOREIGN KEY REFERENCES Kuis(KuisID),
    Jawaban CHAR(1),
    IsCorrect BIT,
    WaktuJawab DATETIME DEFAULT GETDATE()
);

-- =============================================
-- 8. TABEL SERTIFIKAT
-- =============================================
CREATE TABLE Certificate0 (
    CertificateID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    KursusID INT FOREIGN KEY REFERENCES DataKursus(KursusID),
    Nilai FLOAT,
    TanggalDapat DATETIME DEFAULT GETDATE(),
    IsPrinted BIT DEFAULT 0
);

-- =============================================
-- 9. DATA USERS
-- =============================================
INSERT INTO Users (Username, Password, FullName, Email)
VALUES 
('admin1', 'admin123', 'Admin Satu', 'admin1@example.com'),
('user1', 'user123', 'User Pertama', 'user1@example.com');

-- =============================================
-- 10. DATA KURSUS
-- =============================================
INSERT INTO DataKursus (JudulKursus, Deskripsi)
VALUES 
('Dasar-Dasar Pemrograman', 'Belajar dasar-dasar coding menggunakan bahasa C#'),
('Jaringan Komputer', 'Materi tentang pengantar jaringan dan protokol TCP/IP'),
('UI/UX Design', 'Belajar dasar User Interface dan User Experience Design'),
('Database', 'Mengenal sistem basis data dan SQL dasar');

-- =============================================
-- 11. DATA MATERI
-- =============================================
INSERT INTO Materi (KursusID, JudulMateri, LinkVideo, Urutan, DurasiMenit)
VALUES 
(1, 'Pengenalan Pemrograman', 'https://youtu.be/intro-csharp', 1, 10),
(1, 'Variabel dan Tipe Data', 'https://youtu.be/variables-csharp', 2, 12),
(2, 'Apa itu Jaringan?', 'https://youtu.be/networking-intro', 1, 9),
(2, 'Model OSI Layer', 'https://youtu.be/osi-model', 2, 14);

-- =============================================
-- 12. DATA KUIS
-- =============================================

-- Dasar Pemrograman
INSERT INTO Kuis (KursusID, Pertanyaan, PilihanA, PilihanB, PilihanC, PilihanD, JawabanBenar) VALUES
(1, 'Bahasa pemrograman C# dijalankan menggunakan...', 'Compiler', 'Interpreter', 'Assembler', 'Browser', 'A'),
(1, 'Apa tipe data untuk angka pecahan di C#?', 'int', 'string', 'float', 'char', 'C'),
(1, 'Simbol untuk komentar satu baris di C# adalah...', '//', '/*', '#', '--', 'A'),
(1, 'Method Main() berada di dalam...', 'class', 'interface', 'namespace', 'module', 'A'),
(1, 'Variabel di C# tidak bisa diawali dengan...', 'huruf', 'angka', 'underscore', 'tanda dolar', 'B');

-- Jaringan Komputer
INSERT INTO Kuis (KursusID, Pertanyaan, PilihanA, PilihanB, PilihanC, PilihanD, JawabanBenar) VALUES
(2, 'OSI Layer terdiri dari berapa lapisan?', '5', '6', '7', '8', 'C'),
(2, 'Protokol standar untuk transfer file adalah...', 'HTTP', 'FTP', 'SMTP', 'TCP', 'B'),
(2, 'Perangkat yang menghubungkan dua jaringan berbeda adalah...', 'Router', 'Switch', 'Hub', 'Bridge', 'A'),
(2, 'Port standar HTTP adalah...', '21', '80', '443', '25', 'B'),
(2, 'Alamat IP versi 4 terdiri dari...', '16 bit', '32 bit', '64 bit', '128 bit', 'B');

-- UI/UX Design
INSERT INTO Kuis (KursusID, Pertanyaan, PilihanA, PilihanB, PilihanC, PilihanD, JawabanBenar) VALUES
(3, 'Apa singkatan dari UI?', 'User Input', 'User Interface', 'Universal Input', 'Universal Interface', 'B'),
(3, 'UX berfokus pada...', 'Desain grafis', 'Pengalaman pengguna', 'Bahasa pemrograman', 'Koneksi internet', 'B'),
(3, 'Wireframe digunakan untuk...', 'Database', 'Desain tampilan awal', 'Pemrograman', 'Debugging', 'B'),
(3, 'Warna yang umum untuk error adalah...', 'Hijau', 'Biru', 'Merah', 'Kuning', 'C'),
(3, 'Apa itu prototyping?', 'Debugging kode', 'Simulasi aplikasi sebelum jadi', 'Membuat database', 'Hosting aplikasi', 'B');

-- Database
INSERT INTO Kuis (KursusID, Pertanyaan, PilihanA, PilihanB, PilihanC, PilihanD, JawabanBenar) VALUES
(4, 'Apa singkatan dari SQL?', 'Structured Query Language', 'System Query Line', 'Strong Query Logic', 'Secure Query Language', 'A'),
(4, 'Perintah untuk menampilkan data adalah...', 'SELECT', 'SHOW', 'PRINT', 'GET', 'A'),
(4, 'Kunci primer digunakan untuk...', 'Warna tabel', 'Unikkan baris', 'Koneksi user', 'Menambah kolom', 'B'),
(4, 'Perintah untuk menambahkan data ke tabel adalah...', 'INSERT INTO', 'UPDATE', 'MERGE', 'APPEND', 'A'),
(4, 'Fungsi COUNT digunakan untuk...', 'Menjumlah angka', 'Menjumlah baris', 'Menjumlah kolom', 'Menjumlah tabel', 'B');

-- Update
-- KursusID 1: Dasar Pemrograman
INSERT INTO Materi (KursusID, JudulMateri, LinkVideo, Urutan, DurasiMenit) VALUES
(1, 'Pengenalan C#', 'https://youtu.be/CSharpIntro', 1, 10),
(1, 'Variabel dan Tipe Data', 'https://youtu.be/CSharpVariables', 2, 12),
(1, 'Percabangan If Else', 'https://youtu.be/CSharpIfElse', 3, 15),
(1, 'Perulangan For dan While', 'https://youtu.be/CSharpLoops', 4, 14),
(1, 'Array dan List', 'https://youtu.be/CSharpArrays', 5, 13),
(1, 'Method dan Fungsi', 'https://youtu.be/CSharpMethods', 6, 16),
(1, 'Class dan Object', 'https://youtu.be/CSharpClass', 7, 18),
(1, 'Encapsulation & Inheritance', 'https://youtu.be/CSharpOOP', 8, 17),
(1, 'Exception Handling', 'https://youtu.be/CSharpException', 9, 11),
(1, 'Latihan Mini Project', 'https://youtu.be/CSharpProject', 10, 20);

-- KursusID 2: Jaringan Komputer
INSERT INTO Materi (KursusID, JudulMateri, LinkVideo, Urutan, DurasiMenit) VALUES
(2, 'Apa itu Jaringan?', 'https://youtu.be/NetworkIntro', 1, 9),
(2, 'Model OSI Layer', 'https://youtu.be/NetworkOSI', 2, 14),
(2, 'TCP/IP dan Protokol', 'https://youtu.be/TCPIPExplained', 3, 12),
(2, 'IP Address dan Subnetting', 'https://youtu.be/IPSubnetting', 4, 18),
(2, 'Router & Switch', 'https://youtu.be/RouterSwitch', 5, 15),
(2, 'DNS & DHCP', 'https://youtu.be/DNSDHCP', 6, 13),
(2, 'Firewall dan Keamanan', 'https://youtu.be/NetworkFirewall', 7, 16),
(2, 'Topologi Jaringan', 'https://youtu.be/NetworkTopo', 8, 11),
(2, 'Jaringan Wireless', 'https://youtu.be/WirelessNetworking', 9, 10),
(2, 'Simulasi dengan Cisco Packet Tracer', 'https://youtu.be/CiscoSim', 10, 20);

-- KursusID 3: UI/UX Design
INSERT INTO Materi (KursusID, JudulMateri, LinkVideo, Urutan, DurasiMenit) VALUES
(3, 'Apa itu UI/UX?', 'https://youtu.be/IntroUIUX', 1, 8),
(3, 'Prinsip Dasar Desain', 'https://youtu.be/DesignPrinciples', 2, 12),
(3, 'Wireframing', 'https://youtu.be/Wireframe', 3, 10),
(3, 'Mockup vs Prototype', 'https://youtu.be/MockupPrototype', 4, 9),
(3, 'Tools Figma Dasar', 'https://youtu.be/FigmaBasic', 5, 14),
(3, 'User Flow dan Sitemap', 'https://youtu.be/UserFlow', 6, 13),
(3, 'Desain Responsif', 'https://youtu.be/ResponsiveUI', 7, 16),
(3, 'UX Writing', 'https://youtu.be/UXWriting', 8, 11),
(3, 'Heuristic Evaluation', 'https://youtu.be/HeuristicEval', 9, 10),
(3, 'Finalisasi dan Uji Coba', 'https://youtu.be/UXTesting', 10, 15);

-- KursusID 4: Database
INSERT INTO Materi (KursusID, JudulMateri, LinkVideo, Urutan, DurasiMenit) VALUES
(4, 'Pengenalan Database', 'https://youtu.be/DBIntro', 1, 10),
(4, 'Relasi Tabel dan Primary Key', 'https://youtu.be/DBRelation', 2, 11),
(4, 'Bahasa SQL: SELECT', 'https://youtu.be/SQLSelect', 3, 12),
(4, 'SQL: INSERT, UPDATE, DELETE', 'https://youtu.be/SQLModify', 4, 15),
(4, 'JOIN Antar Tabel', 'https://youtu.be/SQLJoin', 5, 16),
(4, 'Fungsi Aggregat (COUNT, SUM)', 'https://youtu.be/SQLAggregate', 6, 13),
(4, 'WHERE dan ORDER BY', 'https://youtu.be/SQLWhereOrder', 7, 11),
(4, 'GROUP BY dan HAVING', 'https://youtu.be/SQLGroupBy', 8, 10),
(4, 'Subquery dan Nested Query', 'https://youtu.be/SQLSubquery', 9, 14),
(4, 'Studi Kasus Mini Project', 'https://youtu.be/SQLProject', 10, 20);

-- Update link available
UPDATE Materi
SET LinkVideo = 'https://www.youtube.com/watch?v=gfkTfcpWqAY'
WHERE JudulMateri = 'Pengenalan C#';

UPDATE Materi
SET LinkVideo = 'https://www.youtube.com/watch?v=JQtxKqjKoXU'
WHERE JudulMateri = 'Percabangan If Else';

UPDATE Materi
SET LinkVideo = 'https://www.youtube.com/watch?v=NbYgm0r7u6o'
WHERE JudulMateri = 'Array dan List';

UPDATE Materi
SET LinkVideo = 'https://www.youtube.com/watch?v=1oN7JxLTVzA'
WHERE JudulMateri = 'Variabel dan Tipe Data';

UPDATE Materi
SET LinkVideo = 'https://www.youtube.com/watch?v=evQk00rCemo'
WHERE JudulMateri = 'Perulangan For dan While';

UPDATE Materi
SET LinkVideo = 'https://www.youtube.com/watch?v=hycocEOIjoI'
WHERE JudulMateri = 'Fungsi dan Prosedur';

UPDATE Materi
SET LinkVideo = 'https://www.youtube.com/watch?v=_Ld8wMr4OZ4'
WHERE JudulMateri = 'Kelas dan Objek';

UPDATE Materi
SET LinkVideo = 'https://www.youtube.com/watch?v=_nmm0nZqIIY'
WHERE JudulMateri = 'Exception Handling';

UPDATE Materi
SET LinkVideo = 'https://www.youtube.com/watch?v=gqlAmSqq6Tw'
WHERE JudulMateri = 'File I/O';

UPDATE Materi
SET LinkVideo = 'https://www.youtube.com/watch?v=EWOENHkxJ0k'
WHERE JudulMateri = 'LINQ';