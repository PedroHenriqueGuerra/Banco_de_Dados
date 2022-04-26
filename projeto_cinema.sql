# ------------------------------- CRIAÇÃO DO AMBIENTE DE TRABALHO ------------------------------- #

CREATE SCHEMA projeto_cinema;

# ------------------------------- CRIAÇÃO DAS TABELAS ------------------------------- #

CREATE TABLE ator
(
    ID                     INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    DRT                    VARCHAR(16),
    Nome                   VARCHAR(128) NOT NULL,
    Seguro_social          VARCHAR(16)  NOT NULL,
    Nacionalidade          VARCHAR(16),
    Data_nasc              DATE,
    Sexo                   CHAR(4),
    Tipo_Papel             VARCHAR(32),
    Quantidade_De_Atuacoes INT          NOT NULL
);

CREATE TABLE estudio
(
    ID                            INT         NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nome                          VARCHAR(32) NOT NULL,
    Proprietario                  VARCHAR(16) NOT NULL,
    Data_fundacao                 DATE,
    Quantidade_Filmes_Produzidos  INT,
    Quantidade_Filmes_Em_Producao INT,
    Faturamento_anterior          DECIMAL(16, 2)
);

CREATE TABLE filme
(
    ID                INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nome              VARCHAR(128) NOT NULL,
    Numero_registro   VARCHAR(16)  NOT NULL,
    Categoria         VARCHAR(16)  NOT NULL,
    Meses_Producao    INT,
    Ano_lancamento    DATE,
    Copywriting       VARCHAR(16),
    Custo             DECIMAL(16, 2),
    Sinopse           VARCHAR(255),
    Faturamento_total DECIMAL(16, 2),
    Duracao           time
);

CREATE TABLE personagem
(
    ID              INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nome_Personagem VARCHAR(128),
    Cache           DECIMAL(16, 2)
);

CREATE TABLE diretor
(
    ID                INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nome              VARCHAR(128) NOT NULL,
    Quantidade_Filmes INT          NOT NULL
);

CREATE TABLE operador_de_camera
(
    ID   INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(128) NOT NULL
);

CREATE TABLE figurinista
(
    ID   INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(128) NOT NULL
);

CREATE TABLE maquiador
(
    ID   INT          NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(128) NOT NULL
);

CREATE TABLE tecnico_De_Som
(
    Nome VARCHAR(128),
    ID   INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE cenografo
(
    Nome VARCHAR(128),
    ID   INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE roteirista
(
    Nome VARCHAR(128),
    ID   INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE editor
(
    Nome VARCHAR(128),
    ID   INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE personagem_filme
(
    ID_personagem INT,
    ID_filme      INT,
    PRIMARY KEY (ID_personagem, ID_filme),
    FOREIGN KEY (ID_personagem) REFERENCES Personagem (ID),
    FOREIGN KEY (ID_filme) REFERENCES Filme (ID)
);

CREATE TABLE ator_filme
(
    ID_ator  INT,
    ID_filme INT,
    PRIMARY KEY (ID_ator, ID_filme),
    FOREIGN KEY (ID_ator) REFERENCES Ator (ID),
    FOREIGN KEY (ID_filme) REFERENCES Filme (ID)
);

CREATE TABLE personagem_maquiador
(
    ID_personagem INT,
    ID_maquiador  INT,
    PRIMARY KEY (ID_personagem, ID_maquiador),
    FOREIGN KEY (ID_personagem) REFERENCES Personagem (ID),
    FOREIGN KEY (ID_maquiador) REFERENCES Maquiador (ID)
);

CREATE TABLE filme_diretor
(
    ID_filme   INT,
    ID_diretor INT,
    PRIMARY KEY (ID_filme, ID_diretor),
    FOREIGN KEY (ID_filme) REFERENCES Filme (ID),
    FOREIGN KEY (ID_diretor) REFERENCES Diretor (ID)
);

CREATE TABLE filme_Tecnico_De_Som
(
    ID_filme          INT,
    ID_Tecnico_De_Som INT,
    PRIMARY KEY (ID_filme, ID_Tecnico_De_Som),
    FOREIGN KEY (ID_filme) REFERENCES Filme (ID),
    FOREIGN KEY (ID_Tecnico_De_Som) REFERENCES Tecnico_De_Som (ID)
);

CREATE TABLE filme_roterista
(
    ID_filme     INT,
    ID_roterista INT,
    PRIMARY KEY (ID_filme, ID_roterista),
    FOREIGN KEY (ID_filme) REFERENCES Filme (ID),
    FOREIGN KEY (ID_roterista) REFERENCES Roteirista (ID)
);

CREATE TABLE filme_cenografo
(
    ID_filme     INT,
    ID_cenografo INT,
    PRIMARY KEY (ID_filme, ID_cenografo),
    FOREIGN KEY (ID_filme) REFERENCES Filme (ID),
    FOREIGN KEY (ID_cenografo) REFERENCES Cenografo (ID)
);

CREATE TABLE filme_editor
(
    ID_filme  INT,
    ID_editor INT,
    PRIMARY KEY (ID_filme, ID_editor),
    FOREIGN KEY (ID_filme) REFERENCES Filme (ID),
    FOREIGN KEY (ID_editor) REFERENCES Editor (ID)
);

CREATE TABLE filme_operador_camera
(
    ID_filme           INT,
    ID_operador_camera INT,
    PRIMARY KEY (ID_filme, ID_operador_camera),
    FOREIGN KEY (ID_filme) REFERENCES Filme (ID),
    FOREIGN KEY (ID_operador_camera) REFERENCES Operador_de_Camera (ID)
);

# ------------------------------- ALTERAÇÃO DAS TABELAS ------------------------------- #

/*
Para adicionar as chaves estrangeiras
*/

ALTER TABLE filme
    ADD id_estudio INT;

ALTER TABLE filme
    ADD CONSTRAINT FOREIGN KEY (id_estudio) REFERENCES estudio (ID);

ALTER TABLE personagem
    ADD id_ator INT;

ALTER TABLE personagem
    ADD CONSTRAINT FOREIGN KEY (id_ator) REFERENCES ator (ID);

ALTER TABLE personagem
    ADD id_figurinista INT;

ALTER TABLE personagem
    ADD CONSTRAINT FOREIGN KEY (id_figurinista) REFERENCES figurinista (ID);

# ------------------------------- POPULAÇÂO DAS TABELAS ------------------------------- #

INSERT INTO estudio(Nome, Proprietario, Data_fundacao, Quantidade_Filmes_Produzidos, Quantidade_Filmes_Em_Producao,
                    Faturamento_anterior)
VALUES ('Cameracao', 'Ines Brasil', '2005-08-31', 2, 0, 1900000),
       ('Filmorama', 'Homer Simpson', '2000-07-21', 5, 2, 26000000),
       ('Cultfilme', 'Jason Friday', '2017-01-16', 3, 0, 900000);

INSERT INTO filme(Nome, Numero_registro, Categoria, Meses_Producao, Ano_lancamento, Copywriting, Custo, Sinopse,
                  Faturamento_total, Duracao, id_estudio)
VALUES ('Limpadores', '02650', 'Acao', 21, '2021-01-20', '2658425', 1600000,
        'A Terra sofre um ataque e Os Limpadores sao convocados para limpar a bagunca.', 2500000, '02:10:00', 1),
       ('Macadasgar', '59865', 'Comedia', 5, '2020-05-02', '65874', 850000,
        'Os animais tentam fugir do zoologico e acabam caindo na ilha de Macadasgar.', 1000000, '02:00:03', 1),
       ('Purassic Jark', '12652', 'Aventura', 19, '1993-09-29', '268562', 2000000,
        'Numa tentativa de criar um parque para dinossauros, dinossauros reais sao criados.', 3500000, '03:00:12', 3),
       ('Diterdivamente', '854692', 'Comedia', 12, '2019-11-03', '856632', 1000000,
        'Mostra o trabalho das emocoes em diferentes fases da vida.', 2000000, '02:15:10', 2),
       ('Nem que o touro espirre', '741235', 'Comedia', 15, '2021-01-12', '963258', 2000000,
        'O touro é raptado e outros touros vao atras dele.', 2500000, '02:10:10', 1),
       ('Rapidos e raivosos', '159654', 'Aventura', 16, '2020-07-08', '784263', 1250000,
        'Filme que mostra as corridas de rua ilegais.', 3000000, '02:05:03', 3),
       ('Estar Guerras', '102301', 'Ficcao', 21, '1995-02-28', '231662', 2350000,
        'Saga de filmes que trata sobre o universo e guerras galaticas.', 4000000, '03:00:05', 1),
       ('Rarry Pobre', '012456', 'Ficcao', 12, '1997-06-28', '743691', 900000,
        'Acompanhe a saga do jovem Rarry descobrindo poderes magicos.', 2100000, '02:30:00', 2),
       ('Para metade dos garotos que ja chorei', '254987', 'Romance', 18, '2018-03-15', '032165', 2000000,
        'Lara Jean tem cartas enviadas a garotos que ja chorou um dia.', 850000, '02:00:00', 3),
       ('O menino listrado de pijama', '741259', 'Drama', 24, '2004-11-23', '215069', 212000,
        'Menino alemao fica amigo de um judeu e tentam manter a amizade com as diferencas.', 1500000, '02:32:00', 1);

INSERT INTO ator(DRT, Nome, Seguro_social, Nacionalidade, Data_nasc, Sexo, Tipo_Papel, Quantidade_De_Atuacoes)
VALUES ('000001', 'Hugo Barbosa', '051254', 'Alemao', '2000-07-21', 'M', 'Vilão', 1),
       ('000002', 'Isaac Barbosa', '254962', 'Estadunidense', '2001-01-16', 'M', 'Prefeito', 2),
       ('000003', 'Pedro Guerra', '589645', 'Brasileiro', '2000-09-04', 'M', 'Herói', 2),
       ('000004', 'João Pedro', '896542', 'Russo', '2000-01-11', 'M', 'Anti-herói', 2),
       ('000005', 'Marcia Imper Ator', '951236', 'Brasileiro', '1969-05-18', 'F', 'Vilão', 1),
       ('000006', 'La Nah Rhodes', '854796', 'Canadense', '1989-12-05', 'F', 'Herói', 1),
       ('000007', 'Saxa Grey', '856321', 'Russo', '1999-04-01', 'F', 'Cientista', 1),
       ('000008', 'Mia Kah Lifa', '741236', 'Alemao', '1979-05-03', 'F', 'Artista', 2),
       ('000009', 'He Lel', '964120', 'Judaico', '1950-08-25', 'M', 'Estrela da manhã', 1),
       ('000010', 'Lisa Ann', '145632', 'Estadunidense', '1970-12-25', 'F', 'Artista', 1);

INSERT INTO cenografo(Nome)
VALUES ('Marcos File Mion'),
       ('Lussiano Hulk'),
       ('Angelica Brito'),
       ('Ruth Raquel'),
       ('Ojuara');

INSERT INTO diretor(Nome, Quantidade_Filmes)
VALUES ('Pedro Miguel', 2),
       ('Casmiro Certezas', 1),
       ('Nobru Apelao', 3),
       ('Gaules', 2),
       ('Alanzoka', 1),
       ('Yo Da', 1);

INSERT INTO editor(Nome)
VALUES ('Lucas Brexe'),
       ('Pedro Vaqueiro'),
       ('Magrao');

INSERT INTO figurinista(Nome)
VALUES ('Ueslei Safadinho'),
       ('Juan Sanctana'),
       ('Kola');

INSERT INTO maquiador(Nome)
VALUES ('Tche Tche'),
       ('Bozzo'),
       ('Parati'),
       ('Paraca');

INSERT INTO personagem(Nome_Personagem, id_ator, id_figurinista, Cache)
VALUES ('Capitao Faxina', 5, 2, 5),
       ('Homem de Berro', 8, 2, 4),
       ('Xela o Leao', 2, 1, 150),
       ('Dino Saulo', 9, 1, 180),
       ('Raiva', 4, 1, 190),
       ('Fernando', 3, 3, 200000),
       ('Torrent', 6, 1, 1500),
       ('Paulo Walker', 7, 3, 1600),
       ('Ioda', 1, 3, 15000),
       ('Valder', 10, 1, 16000),
       ('Rarry', 2, 2, 1000),
       ('Larissa', 8, 2, 12000),
       ('Bruno War', 3, 3, 5000),
       ('Samuel Paz', 4, 3, 5000);

INSERT INTO roteirista(Nome)
VALUES ('Latino'),
       ('Miano');

INSERT INTO tecnico_De_Som(Nome)
VALUES ('Alan Brado'),
       ('Fizza Now'),
       ('Pecanha');

INSERT INTO operador_de_camera(Nome)
VALUES ('Alan'),
       ('Neide Costa');

INSERT INTO ator_filme(ID_ator, ID_filme)
VALUES (5, 1),
       (8, 1),
       (2, 2),
       (9, 3),
       (4, 4),
       (3, 5),
       (6, 6),
       (7, 6),
       (1, 7),
       (10, 7),
       (2, 8),
       (8, 9),
       (3, 10),
       (4, 10);

INSERT INTO filme_cenografo(ID_filme, ID_cenografo)
VALUES (1, 3),
       (2, 2),
       (3, 3),
       (4, 1),
       (5, 1),
       (6, 3),
       (7, 2),
       (8, 1),
       (9, 2),
       (10, 3);

INSERT INTO filme_diretor(ID_filme, ID_diretor)
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 4),
       (6, 3),
       (7, 3),
       (8, 1),
       (9, 5),
       (10, 6);

INSERT INTO filme_operador_camera(ID_filme, ID_operador_camera)
VALUES (1, 1),
       (2, 1),
       (3, 2),
       (4, 1),
       (5, 1),
       (6, 2),
       (7, 2),
       (8, 1),
       (9, 2),
       (10, 1);

INSERT INTO filme_roterista(ID_filme, ID_roterista)
VALUES (1, 2),
       (2, 1),
       (3, 2),
       (4, 2),
       (5, 1),
       (6, 2),
       (7, 1),
       (8, 1),
       (9, 2),
       (10, 1);

INSERT INTO filme_tecnico_de_som(ID_filme, ID_Tecnico_De_Som)
VALUES (1, 1),
       (2, 3),
       (3, 2),
       (4, 1),
       (5, 3),
       (6, 2),
       (7, 2),
       (8, 1),
       (9, 3),
       (10, 1);

INSERT INTO personagem_filme(ID_personagem, ID_filme)
VALUES (1, 1),
       (2, 1),
       (3, 2),
       (4, 3),
       (5, 4),
       (6, 5),
       (7, 6),
       (8, 7),
       (9, 7),
       (10, 8),
       (11, 8),
       (12, 9),
       (13, 10),
       (14, 10);

INSERT INTO personagem_maquiador(ID_personagem, ID_maquiador)
VALUES (1, 4),
       (2, 4),
       (3, 2),
       (4, 1),
       (5, 2),
       (6, 3),
       (7, 4),
       (8, 3),
       (9, 3),
       (10, 2),
       (11, 1),
       (12, 1),
       (13, 1),
       (14, 4);

# ------------------------------- CONSULTAS ------------------------------- #

# Estudio que produziu mais filmes

SELECT nome, MAX(Quantidade_Filmes_Produzidos) as quantidade
FROM estudio;

# Identificação de qual categoria de filmes é mais produzida nos estúdios de Hollywood

SELECT MAX(Categoria)
FROM filme;

# Relação, por categoria, do número de filmes produzido por cada estúdio

SELECT est.Nome, fil.Categoria, count(est.Nome)
FROM filme fil
         LEFT JOIN estudio est ON fil.id_estudio = est.ID
GROUP BY fil.Categoria, est.Nome
ORDER BY est.Nome;

# Identificação do ator (ou atriz) mais jovem e o ator (ou atriz) mais velho(a) de Hollywood;

SELECT NOME, timestampdiff(YEAR, Data_nasc, NOW()) as idade
FROM ator
WHERE Data_nasc IN (SELECT MIN(Data_nasc) FROM ator)
   OR Data_nasc IN (SELECT MAX(Data_nasc) FROM ator);

# Identificação do filme mais caro;

SELECT nome AS nome_do_filme, Custo AS valor
FROM filme
WHERE Custo IN (SELECT MAX(Custo) FROM filme);

# Identificação da idade média para um ator atuar como “Artista”.

SELECT SUM(timestampdiff(YEAR, Data_nasc, NOW())) / count(Tipo_Papel like 'Artista') AS idade
FROM ator
WHERE Tipo_Papel like 'Artista';

# Diretor com mais filmes

SELECT Nome, Quantidade_Filmes
FROM diretor
WHERE Quantidade_Filmes IN (SELECT MAX(Quantidade_Filmes) FROM diretor)
GROUP BY Nome;

# Filme com maior bilheteria

SELECT nome AS nome_do_filme, Faturamento_total AS valor
FROM filme
WHERE Faturamento_total IN (SELECT MAX(Faturamento_total) FROM filme);

# Ator (es) com menos filmes

SELECT nome, Quantidade_De_Atuacoes
FROM ator
WHERE Quantidade_De_Atuacoes IN (SELECT MIN(Quantidade_De_Atuacoes) FROM ator);

# Personagem do filme Limpadores com maior cache

SELECT p.Nome_Personagem, MAX(p.Cache)
FROM personagem_filme pf
         LEFT JOIN personagem p ON pf.ID_personagem = p.ID
         LEFT JOIN filme f ON pf.ID_filme = f.ID
WHERE f.Nome like 'Limp%';