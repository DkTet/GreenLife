create database greenlife;
use greenlife;

-- Tabela de Usuários
create table usuarios (
	usu_codigo int not null auto_increment primary key,
    usu_nomeusuario varchar(50) not null,
    usu_email varchar(255) not null,
	usu_senha varchar(255) not null,
	usu_foto varchar(255) default "default.png",
	usu_criado timestamp default current_timestamp,
	usu_suspenso tinyint default 0
);

-- Tabela de Admins
create table admins (
	adm_codigo int not null auto_increment primary key,
    adm_email char(50) not null unique,
    adm_senha char(15) not null,
    adm_nome char(20) DEFAULT NULL
);


-- ---------------------------Parte para as Dicas/Categorias------------------------------------------


create table categorias (
  cat_codigo int not null auto_increment primary key,
  cat_nome char(50) not null,
  cat_nomenormal char(50) not null
);


-- Tabela de Dicas
create table dicas (
  dic_codigo int not null auto_increment primary key,
  dic_titulo varchar(100) not null,
  dic_conteudo varchar(255) not null,
  dic_imagem varchar(255),
  dic_data timestamp default current_timestamp,
  adm_codigo int not null,
  cat_codigo int,
  foreign key (adm_codigo) references admins(adm_codigo),
  foreign key (cat_codigo) references categorias(cat_codigo)
);


create table salvos_dicas (
  usu_codigo int,
  dic_codigo int,
  primary key (usu_codigo, dic_codigo),
  foreign key (usu_codigo) references usuarios(usu_codigo),
  foreign key (dic_codigo) references dicas(dic_codigo)
);

-- Tabela Dica do Dia
create table dia_dica (
  dia_codigo int not null auto_increment primary key,
  dia_conteudo varchar(255) not null,
  dia_criado timestamp default current_timestamp
);

-- -------------------------Parte para as Publicações--------------------------------------------


-- Tabela de Publicações
create table publicacoes (
  pub_codigo int not null auto_increment primary key,
  pub_conteudo varchar(255),
  pub_criado timestamp default current_timestamp,
  pub_bloqueado tinyint default 0,
  pub_resposta int default null,
  pub_repostado int default null,
  pub_qtdrespostas int default 0,
  pub_qtdrepostado int default 0,
  pub_qtdcurtiu int default 0,
  pub_qtdsalvo int default 0,
  pub_anexo varchar(255),
  usu_codigo int not null,
  foreign key (usu_codigo) references usuarios(usu_codigo),
  foreign key (pub_resposta) references publicacoes(pub_codigo),
  foreign key (pub_repostado) references publicacoes(pub_codigo)
);

create table curtidas_publicacoes (
  usu_codigo int,
  pub_codigo int,
  primary key (usu_codigo, pub_codigo),
  foreign key (usu_codigo) references usuarios(usu_codigo),
  foreign key (pub_codigo) references publicacoes(pub_codigo)
);

create table salvos_publicacoes (
  usu_codigo int,
  pub_codigo int,
  primary key (usu_codigo, pub_codigo),
  foreign key (usu_codigo) references usuarios(usu_codigo),
  foreign key (pub_codigo) references publicacoes(pub_codigo)
);


-- ------------------------Parte para os Comentários---------------------------------------------


-- Tabela de Comentários
create table comentarios (
  com_codigo int not null auto_increment primary key,
  com_conteudo text not null,
  com_criado timestamp default current_timestamp,
  com_curtidas int default 0,
  com_deslikes int default 0,
  usu_codigo int not null,
  dic_codigo int default null,
  pub_codigo int default null,
  com_resposta int default null,
  foreign key (usu_codigo) references usuarios(usu_codigo),
  foreign key (dic_codigo) references dicas(dic_codigo),
  foreign key (pub_codigo) references publicacoes(pub_codigo),
  foreign key (com_resposta) references comentarios(com_codigo)
);

create table curtidas_comentarios (
  usu_codigo int,
  com_codigo int,
  primary key (usu_codigo, com_codigo),
  foreign key (usu_codigo) references usuarios(usu_codigo),
  foreign key (com_codigo) references comentarios(com_codigo)
);

create table deslikes_comentarios (
  usu_codigo int,
  com_codigo int,
  primary key (usu_codigo, com_codigo),
  foreign key (usu_codigo) references usuarios(usu_codigo),
  foreign key (com_codigo) references comentarios(com_codigo)
);


-- ---------------------Tabela Seguidores------------------------------------------------


create table seguidores (
  seguidor_id int,
  seguido_id int,
  primary key (seguidor_id, seguido_id),
  foreign key (seguidor_id) references usuarios(usu_codigo),
  foreign key (seguido_id) references usuarios(usu_codigo)
);



INSERT INTO categorias (cat_nome, cat_nomenormal) VALUES
('Meio Ambiente', 'meioambiente'),
('Reciclagem', 'reciclagem');

INSERT INTO publicacoes (pub_conteudo, pub_anexo, usu_codigo) VALUES
('🌱 Comecei minha horta orgânica hoje!', NULL, 1),
('♻️ Dica: separe seu lixo reciclável corretamente!', NULL, 3),
('🍃 Que dia lindo para plantar árvores!', 'plantio.jpeg', 2);

INSERT INTO dia_dica (dia_conteudo) VALUES 
('Beba água regularmente ao longo do dia para manter-se hidratado.');

INSERT INTO dia_dica (dia_conteudo) VALUES 
('Organize suas tarefas por prioridade para aumentar sua produtividade.');

INSERT INTO dia_dica (dia_conteudo) VALUES 
('Lembre-se de fazer pausas durante longos períodos de estudo ou trabalho.');

insert into categorias (cat_nome, cat_nomenormal) values
('Saúde & Bem-Estar', 'saude'),
('Sustentabilidade', 'sustentabilidade'),
('Alimentação Saudável', 'alimentacao'),
('Reciclagem e Reutilização', 'reciclagem'),
('Consumo Consciente', 'consumo');

insert into dicas (dic_titulo, dic_conteudo, dic_imagem, adm_codigo, cat_codigo) values
('Beba mais água diariamente', 'Manter-se hidratado é essencial para a saúde. Tente carregar uma garrafinha com você o tempo todo.', 'default.jpg', 1, 1),
('Reduza o uso de plástico', 'Opte por garrafas reutilizáveis e sacolas de pano para reduzir o impacto ambiental.', 'default.jpg', 1, 2),
('Inclua vegetais na dieta diária', 'Vegetais são ricos em nutrientes e fibras. Tente adicionar saladas às suas refeições.', 'default.jpg', 1, 3),
('Separe seu lixo corretamente', 'A separação correta do lixo facilita a reciclagem e ajuda o meio ambiente.', 'default.jpg', 1, 4),
('Compre apenas o necessário', 'Evite desperdício de alimentos e produtos comprando somente o que realmente precisa.', 'default.jpg', 1, 5);

