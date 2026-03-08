CREATE DATABASE IF NOT EXISTS projeto_padawan;
USE projeto_padawan;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('orientador','adm','mentor','calouro') NOT NULL,
    mentor_id INT,
    FOREIGN KEY (mentor_id) REFERENCES usuarios(id) ON DELETE SET NULL
);

CREATE TABLE grupo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL,
    adm_id INT NOT NULL,
    FOREIGN KEY (adm_id) REFERENCES usuarios(id)
);

CREATE TABLE grupo_membros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    grupo_id INT NOT NULL,
    usuario_id INT NOT NULL UNIQUE,
    FOREIGN KEY (grupo_id) REFERENCES grupo(id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE TABLE vinculos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mentor_id INT NOT NULL,
    calouro_id INT NOT NULL,
    grupo_id INT,
    FOREIGN KEY (mentor_id) REFERENCES usuarios(id),
    FOREIGN KEY (calouro_id) REFERENCES usuarios(id),
    FOREIGN KEY (grupo_id) REFERENCES grupo(id),
    UNIQUE (mentor_id, calouro_id)
);

CREATE TABLE encontros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    mentor_id INT NOT NULL,
    calouro_id INT NOT NULL,
    data_realizacao DATE NOT NULL,
    duracao_minutos INT NOT NULL,
    detalhamento TEXT,
    FOREIGN KEY (mentor_id) REFERENCES usuarios(id),
    FOREIGN KEY (calouro_id) REFERENCES usuarios(id)
);

CREATE TABLE mensagens_chat (
    id INT AUTO_INCREMENT PRIMARY KEY,
    remetente_id INT NOT NULL,
    destinatario_id INT NOT NULL,
    mensagem TEXT NOT NULL,
    data_envio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (remetente_id) REFERENCES usuarios(id),
    FOREIGN KEY (destinatario_id) REFERENCES usuarios(id)
);



INSERT INTO usuarios (nome, email, senha, tipo)
VALUES ('Quezia Costa', 'quezbea@gmail.com', '123456', 'adm');

SELECT 
    m.nome AS mentor,
    c.nome AS calouro
FROM vinculos v
JOIN usuarios m ON v.mentor_id = m.id
JOIN usuarios c ON v.calouro_id = c.id;

