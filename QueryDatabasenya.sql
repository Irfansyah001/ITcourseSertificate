-- Tabel Users (admin input manual)
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL,
    FullName VARCHAR(100),
    Email VARCHAR(100)
);

-- Tabel Kursus
CREATE TABLE DataKursus (
    KursusID INT PRIMARY KEY IDENTITY(1,1),
    JudulKursus VARCHAR(100) NOT NULL,
    Deskripsi TEXT
);

-- Tabel Materi
CREATE TABLE Materi (
    MateriID INT PRIMARY KEY IDENTITY(1,1),
    KursusID INT FOREIGN KEY REFERENCES DataKursus(KursusID),
    JudulMateri VARCHAR(100),
    LinkVideo VARCHAR(255)
);

-- Tabel Kuis
CREATE TABLE Kuis (
    KuisID INT PRIMARY KEY IDENTITY(1,1),
    KursusID INT FOREIGN KEY REFERENCES DataKursus(KursusID),
    Pertanyaan TEXT NOT NULL,
    PilihanA VARCHAR(100),
    PilihanB VARCHAR(100),
    PilihanC VARCHAR(100),
    PilihanD VARCHAR(100),
    JawabanBenar CHAR(1) CHECK (JawabanBenar IN ('A','B','C','D'))
);

-- Tabel Jawaban User
CREATE TABLE JawabanUser (
    JawabanID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    KuisID INT FOREIGN KEY REFERENCES Kuis(KuisID),
    Jawaban CHAR(1),
    IsCorrect BIT,
    WaktuJawab DATETIME DEFAULT GETDATE()
);

-- Tabel Sertifikat
CREATE TABLE Certificate (
    CertificateID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES Users(UserID),
    KursusID INT FOREIGN KEY REFERENCES DataKursus(KursusID),
    Nilai FLOAT,
    TanggalDapat DATETIME DEFAULT GETDATE()
);


-- Tabel Users
INSERT INTO Users (Username, Password, FullName, Email)
VALUES 
('admin1', 'admin123', 'Admin Satu', 'admin1@example.com'),
('user1', 'user123', 'User Pertama', 'user1@example.com');

-- Tabel DataKursus
INSERT INTO DataKursus (JudulKursus, Deskripsi)
VALUES 
('Dasar-Dasar Pemrograman', 'Belajar dasar-dasar coding menggunakan bahasa C#'),
('Jaringan Komputer', 'Materi tentang pengantar jaringan dan protokol TCP/IP');

-- Tabel Materi
INSERT INTO Materi (KursusID, JudulMateri, LinkVideo)
VALUES 
(1, 'Pengenalan Pemrograman', 'https://youtu.be/intro-csharp'),
(1, 'Variabel dan Tipe Data', 'https://youtu.be/variables-csharp'),
(2, 'Apa itu Jaringan?', 'https://youtu.be/networking-intro'),
(2, 'Model OSI Layer', 'https://youtu.be/osi-model');

-- Tabel Kuis
INSERT INTO Kuis (KursusID, Pertanyaan, PilihanA, PilihanB, PilihanC, PilihanD, JawabanBenar)
VALUES 
(1, 'Bahasa pemrograman C# dijalankan menggunakan...', 'Compiler', 'Interpreter', 'Assembler', 'Browser', 'A'),
(2, 'OSI Layer terdiri dari berapa lapisan?', '5', '6', '7', '8', 'C');

