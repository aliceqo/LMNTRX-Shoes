create database LMNTRX;
use LMNTRX;
SHOW TABLES;

create table usuario (
    id_usuario int not null auto_increment primary key,
    nome varchar(100) not null,
    email varchar(255) unique not null,
    senha varchar(255) not null,
    telefone varchar(15) not null,
    role ENUM('admin', 'vendedor', 'cliente') NOT NULL
);

create table endereco (
    id_endereco int primary key auto_increment not null,
    id_usuario int not null,
    logradouro varchar(100) not null,
    numero int not null,
    complemento varchar(50),
    cidade varchar(100) not null,
    estado varchar(50) not null,
    cep varchar(10) not null,
    foreign key (id_usuario) references usuario(id_usuario)
);

create table categoria (
    id_categoria int primary key auto_increment not null,
    nome_categoria varchar(100) not null
);

create table produto (
    id_produto int primary key auto_increment not null,
    id_categoria int not null,
    nome varchar(100) not null,
    descricao text not null,
    preco decimal(10, 2) not null,
    estoque int not null,
    cor varchar(50) not null,
    marca varchar(50) not null,
    imagem_url varchar(255) not null,
    tamanho varchar(50) not null,
    foreign key (id_categoria) references categoria(id_categoria)
);

create table pedido (
    id_pedido int not null auto_increment primary key,
    id_usuario int not null,
    data_pedido date not null,
    status varchar(50) not null,
    total decimal(10, 2) not null,
    foreign key (id_usuario) references usuario(id_usuario)
);

create table pagamento (
    id_pagamento int primary key auto_increment not null,
    id_pedido int not null,
    metodo_pagamento varchar(50) not null,
    status_pagamento varchar(50) not null,
    valor decimal(10, 2) not null,
    data_pagamento date not null,
    foreign key (id_pedido) references pedido(id_pedido)
);

create table item_pedido (
    id_item_pedido int primary key auto_increment not null,
    id_pedido int not null,
    id_produto int not null,
    quantidade int not null,
    preco_unitario decimal(10, 2) not null,
    foreign key (id_pedido) references pedido(id_pedido),
    foreign key (id_produto) references produto(id_produto)
);

create table avaliacao (
    id_avaliacao int primary key auto_increment not null,
    id_usuario int not null,
    id_produto int not null,
    nota int not null,
    comentario text,
    data_avaliacao date not null,
    foreign key (id_usuario) references usuario(id_usuario),
    foreign key (id_produto) references produto(id_produto)
);

CREATE TABLE acesso_pedido (
    id_pedido INT NOT NULL,
    id_usuario INT NOT NULL, 
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    PRIMARY KEY (id_pedido, id_usuario)
);

-- Inserções de exemplo
INSERT INTO usuario (nome, email, senha, telefone, role) VALUES
('Admin', 'admin@gmail.com', 'senhaadmin', '1234567890', 'admin'),
('Vendedor', 'vendedor@gmail.com', 'senhavendedor', '0987654321', 'vendedor'),
('Cliente', 'cliente@gmail.com', 'senhacliente', '1122334455', 'cliente');

INSERT INTO categoria (nome_categoria) VALUES
('Automobilismo'), 
('Aventura'), 
('Basquete'), 
('Caminhada'), 
('Corrida'), 
('Esporte-de-Quadra'), 
('Streetwar'), 
('Tennis e Squash'), 
('Ofertas');

INSERT INTO produto (nome, marca, descricao, preco, estoque, id_categoria, cor, imagem_url, tamanho) VALUES
('Tênis Qix Skate Retrô AM Preto Cinza Branco', 'Qix', 'Tênis de skate retrô em cores clássicas', 239.99, 20, (SELECT id_categoria FROM categoria WHERE nome_categoria = 'Streetwar'), 'Preto', 'url_da_imagem', '42'),
('Tênis Puma MAPF1 Neo Cat - Branco', 'Puma', 'Tênis inspirado no automobilismo', 499.90, 15, (SELECT id_categoria FROM categoria WHERE nome_categoria = 'Automobilismo'), 'Branco', 'url_da_imagem', '41'),
('Tênis Under Armour Basquete Spawn 3 Masculino - Vermelho+Branco', 'Under Armour', 'Tênis de basquete de alta performance', 237.49, 10, (SELECT id_categoria FROM categoria WHERE nome_categoria = 'Basquete'), 'Vermelho+Branco', 'url_da_imagem', '43');

INSERT INTO pedido (id_usuario, data_pedido, status, total) VALUES
(2, CURDATE(), 'Pendente', 499.99);

INSERT INTO acesso_pedido (id_pedido, id_usuario)
SELECT p.id_pedido, 1 FROM pedido p WHERE p.id_usuario != 1;

INSERT INTO acesso_pedido (id_pedido, id_usuario)
SELECT p.id_pedido, 2 FROM pedido p WHERE p.id_usuario = 2;