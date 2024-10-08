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
);
