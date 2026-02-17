
CREATE DATABASE IF NOT EXISTS projeto_padawan;
USE projeto_padawan;

-
CREATE TABLE IF NOT EXISTS usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('orientador', 'adm', 'mentor', 'calouro') NOT NULL,
    mentor_id INT,
    CONSTRAINT fk_mentor FOREIGN KEY (mentor_id) REFERENCES usuarios(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS encontros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mentor_id INT NOT NULL,
    calouro_id INT NOT NULL,
    data_realizacao DATE NOT NULL,
    duracao_minutos INT NOT NULL, 
    detalhamento TEXT NOT NULL,
    FOREIGN KEY (mentor_id) REFERENCES usuarios(id),
    FOREIGN KEY (calouro_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS grupo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    adm_id INT NOT NULL,
    membros TEXT NOT NULL,
    FOREIGN KEY (adm_id) REFERENCES usuarios(id)
);

CREATE TABLE IF NOT EXISTS vinculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mentor_id INT NOT NULL,
    calouro_id INT NOT NULL,
    grupo_id INT NOT NULL,
    FOREIGN KEY (mentor_id) REFERENCES usuarios(id),
    FOREIGN KEY (calouro_id) REFERENCES usuarios(id),
    FOREIGN KEY (grupo_id) REFERENCES grupo(id)
);