create database LMNTRX;
use LMNTRX;

create table usuario (
 id_usuario int not null auto_increment primary key,
 nome varchar(100) not null,
 email varchar(255) unique not null,
 senha varchar(255) not null,
 telefone varchar(15) not null
);

create table endereco (
 id_endereco int primary key auto_increment not null,
 id_usuario int not null,
 logradouro varchar (100) not null,
 numero int not null,
 complemento varchar (50),
 cidade varchar (100) not null,
 estado varchar (50) not null,
 cep varchar (10) not null,
 foreign key (id_usuario) references usuario (id_usuario)
);
create table pedido (
 id_pedido int not null auto_increment primary key,
 id_usuario int not null,
 data_pedido date not null,
 status varchar (50) not null,
 total decimal (10, 2) not null,
 foreign key (id_usuario) references usuario (id_usuario)
);

create table pagamento (
 id_pagamento int primary key auto_increment not null,
 id_pedido int not null,
 metodo_pagamento varchar (50) not null,
 status_pagamento varchar (50) not null,
 valor decimal (10, 2) not null,
 data_pagamento date not null,
 foreign key (id_pedido) references pedido (id_pedido)
);

create table item_pedido (
 id_item_pedido int primary key auto_increment not null,
 id_pedido int not null,
 id_produto int not null,
 quantidade int not null,
 preco_unitario decimal (10, 2) not null,
 foreign key (id_pedido) references pedido (id_pedido),
 foreign key (id_produto) references produto (id_produto)
);

create table produto (
 id_produto int primary key auto_increment not null,
 id_categoria int not null,
 nome varchar (100) not null,
 descricao text not null,
 preco decimal (10, 2) not null,
 estoque int not null,
 cor varchar (50) not null,
 marca varchar (50) not null,
 imagem_url varchar (255) not null,
 tamanho varchar (50) not null,
 foreign key (id_categoria) references categoria (id_categoria) 
);

create table categoria (
 id_categoria int primary key auto_increment not null,
 nome_categoria varchar (100) not null
);

create table avaliacao (
 id_avaliacao int primary key auto_increment not null,
 id_usuario int not null,
 id_produto int not null,
 nota int not null,
 comentario text,
 data_avaliacao date not null,
 foreign key (id_usuario) references usuario (id_usuario),
 foreign key (id_produto) references produto (id_produto) 


INSERT INTO categoria (nome) VALUES ('Automobilismo'), ('Aventura'), ('Basquete'), ('Caminhada'), ('Corrida'), ('Esporte-de-Quadra'), ('Streetwar'), ('Tennis e Squash'), ('Ofertas');

INSERT INTO tenis (nome, marca, descricao, preco, estoque, categoria_id, data_cadastro) VALUES ('Tênis Qix Skate Retrô AM Preto Cinza Branco', 'Qix', 'Tênis de skate retrô em cores clássicas', 239.99, 20, (SELECT id_categoria FROM categoria WHERE nome = 'Streetwar'), NOW()), ('Tênis Puma MAPF1 Neo Cat - Branco', 'Puma', 'Tênis inspirado no automobilismo', 499.90, 15, (SELECT id_categoria FROM categoria WHERE nome = 'Automobilismo'), NOW()), ('Tênis Under Armour Basquete Spawn 3 Masculino - Vermelho+Branco', 'Under Armour', 'Tênis de basquete de alta performance', 237,49, 10, (SELECT id_categoria FROM categoria WHERE nome = 'Basquete'), NOW()), ('Tênis Adidas Ultra Energy Feminino - Rosa', 'Adidas', 'Tênis feminino para corrida com alta absorção de impacto', 227,99, 25, (SELECT id_categoria FROM categoria WHERE nome = 'Corrida'), NOW()), ('Tênis Feminino Mizuno Advance - Azul Claro+Bege', 'Mizuno', 'Tênis feminino ideal para caminhadas', 227,99, 30, (SELECT id_categoria FROM categoria WHERE nome = 'Caminhada'), NOW()), ('Tênis Asics Gel Resolution 9 Branco e Laranja', 'Asics', 'Tênis de alta performance para tennis', 999,00, 12, (SELECT id_categoria FROM categoria WHERE nome = 'Tennis e Squash'), NOW()), ('Tênis Fila Axilus Ace Masculino - Marinho+Vermelho', 'Fila', 'Tênis masculino de alta performance para quadras',284,99, 18, (SELECT id_categoria FROM categoria WHERE nome = 'Esporte-de-Quadra'), NOW()), ('Bota Cano Alto Macboot Guarani 02 Masculina - Kaki', 'Macboot', 'Bota masculina ideal para aventuras e caminhadas', 389.90, 10, (SELECT id_categoria FROM categoria WHERE nome = 'Aventura'), NOW()), ('Tênis skate TW branco e verde', 'TW', 'Tênis de skate com estilo moderno', 194.90, 20, (SELECT id_categoria FROM categoria WHERE nome = 'Streetwar'), NOW()), ('Tênis Air Jordan 1 Elevate Low Feminino', 'Air Jordan', 'Tênis feminino icônico, modelo Elevate Low', 1082.99, 8, (SELECT id_categoria FROM categoria WHERE nome = 'Streetwar'), NOW());


CRUD - Categoria


Create(inserir categoria)
INSERT INTO categoria (nome) VALUES ('Nova Categoria');

Read(consultar categoria)
SELECT * FROM categoria;

Update (Atualizar Categoria por ID)
UPDATE categoria SET nome = 'Novo Nome da Categoria' WHERE id_categoria = 1;

Delete (Excluir Categoria por ID)
DELETE FROM categoria WHERE id_categoria = 1;

CRUD - Tenis 
Create (Inserir Tênis)

INSERT INTO produto(
 nome,
 descricao,
 preco decimal (10, 2),
 estoque,
 cor varchar,
 marca varchar,
 imagem_url,
 tamanho
)
VALUES ('Nome do Tênis', 'Marca', 'Descrição', 399.99, 20, (SELECT id_categoria FROM categoria WHERE nome = 'Categoria Correspondente'), NOW());

Read (Consultar Tênis)
Consultar todos os tênis:
SELECT * FROM tenis;

Consultar tênis de uma categoria específica:
SELECT * FROM tenis WHERE categoria_id = (SELECT id_categoria FROM categoria WHERE nome = 'Corrida');

Update (Atualizar Tênis por ID)
UPDATE tenis SET preco = 499.99, estoque = 15 WHERE id_tenis = 1;

Delete (Excluir Tênis por ID)
DELETE FROM tenis WHERE id_tenis = 1;



);
CREATE TABLE role (
  id_role INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  nome_role VARCHAR(50) NOT NULL UNIQUE
);
INSERT INTO role (nome_role) VALUES ('admin'), ('vendedor'), ('cliente');

CREATE TABLE usuario_role (
  id_usuario INT NOT NULL,
  id_role INT NOT NULL,
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  FOREIGN KEY (id_role) REFERENCES role(id_role),
  PRIMARY KEY (id_usuario, id_role)
);

CREATE TABLE acesso_pedido (
  id_pedido INT NOT NULL,
  id_usuario INT NOT NULL, -- Usuário que pode acessar o pedido
  FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
  PRIMARY KEY (id_pedido, id_usuario)
);

INSERT INTO pedido (id_usuario, descricao, data_pedido, status_pedido)
VALUES (2, 'Pedido de tênis esportivo', NOW(), 'Pendente'); -- ID do usuário que fez o pedido (vendedor ou cliente)

INSERT INTO acesso_pedido (id_pedido, id_usuario)
SELECT p.id_pedido, 1 -- O admin com id_usuario = 1
FROM pedido p
WHERE p.id_usuario != 1; -- Todos os pedidos que não são do admin

INSERT INTO acesso_pedido (id_pedido, id_usuario)
SELECT p.id_pedido, 2 -- O vendedor com id_usuario = 2
FROM pedido p
WHERE p.id_usuario = 2 OR p.id_usuario IN (SELECT u.id_usuario FROM usuario_role ur JOIN usuario u ON u.id_usuario = ur.id_usuario WHERE ur.id_role = (SELECT id_role FROM role WHERE nome_role = 'cliente'));
020
INSERT INTO acesso_pedido (id_pedido, id_usuario)
SELECT p.id_pedido, 3 -- O cliente com id_usuario = 3
FROM pedido p
WHERE p.id_usuario = 3;


