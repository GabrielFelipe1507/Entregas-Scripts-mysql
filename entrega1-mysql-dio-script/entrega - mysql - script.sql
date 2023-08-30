-- criação do banco de dados para o cenário de E-commerce:
drop database e_commerce;
create database e_commerce;
use e_commerce;
show databases;

-- criar tabela cliente:
create table Clientes(
	idCliente int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    endereco varchar(255),	
	constraint unique_cpf_client unique(CPF)
);
desc Clientes;

-- criar tabela produto:
-- size = dimensão do produto:
create table produto(
	idProduto int auto_increment primary key,
    Pname varchar(10) not null,
    classification_kids bool default false,
    categoria enum('Eletrônico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') not null,
    avaliacao float default 0,
    size varchar(10)	
);
desc produto;

-- criar tabela pagamentos: - termine de implementar a tabela e crie a conexão com as tabelas necessárias
-- além disso, reflita essa modificação no diagrama de esquema relacional:
-- criar constraints relacionadas ao pagamento(payments):
/*create table pagamentos(
	idCliente int primary key,
    idPagamento int,
    typePagamento enum('Boleto', 'Cartão', 'Dois Cartões'),
    limitAvaliable float,
    primary key(idCliente, id_pagamento)
);
desc pagamentos;*/

-- criar a tabela orders():
-- drop table orders;
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
    orderDescription varchar (255),
    sendValue float default 10,
    paymentCash boolean default false,
    constraint fk_orders_client foreign key(idOrderClient) references Clientes(idCliente)
		on update cascade
);
desc orders;

-- criar tabela estoque(productStorage):
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantidade int default 0,
    paymentCash boolean default false
);
desc productStorage;

-- tabela produto_vendedor:
create table produtoSeller(
	idPseller int,
    idProduto int,
    prodQuantidade int default 1,
    primary key(idPseller, idProduto),
    constraint fk_product_seller foreign key(idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idProduto) references Produto(idProduto)
);
desc produtoSeller;

-- criar tabela pedido(productOrder):
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
	poStatus enum('Disponivel', 'Sem estoque') default 'Disponivel',
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key(idPOproduct) references produto(idProduto),
    constraint fk_productorder_product foreign key(idPOorder) references orders(idOrder)
);
desc productOrder;

-- criar tabela pedido(productOrder):
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key(idLproduct) references produto(idProduto),
    constraint fk_storage_location_storage foreign key(idLstorage) references productStorage(idProdStorage)
);
desc storageLocation;
-- criar tabela fornecedor(supplier):
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contato varchar(11) not null,
    constraint unique_suppleir unique (CNPJ)
);
desc supplier;

-- criar tabela vendedor(seller)
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15) not null,
    CPF char(9),
    location varchar(255),
    contato char(11) not null,
    constraint unique_cnpj_suppleir unique (CNPJ),
    constraint unique_cpf_suppleir unique (CPF)
);
desc seller;
show tables;
use company_constraints;
use e_commerce;
desc referential_constraints;
select * from referential_constraints where constraint_schema = 'e_commerce';

-- INSERÇÕES:
select * from Clientes;
insert into Clientes(Fname, Minit, Lname, CPF, endereco)
	values('Maria', 'M', 'Silva', 123456789, 'rua silva de prata 2000, Bairro2 - Cidade das flores'),
		  ('Matheus', 'O', 'Pimentel', 987654321, 'rua alameda 2890, Centro - Cidade das flores'),
		  ('Ricardo', 'F', 'Assis', 123446789, 'rua silva de prata 2909, Carangola - Cidade das flores'),
		  ('Maria', 'S', 'Cristina', 123476789, 'rua duque de caxias, Bairro1 - Bataguassu'),
		  ('José', 'G', 'Santos', 123456989, 'rua prado de prata 1020, Periferia - São Paulo'),
		  ('Ana', 'M', 'Souza', 123455789, 'rua santos de prata 2001, Centro - Recanto dos Palmares');
-- **********************
select*from produto;
insert into produto(Pname, classification_kids, categoria, avaliacao, size) 
	values('Carrinho', false, 'Eletrônico', '4', null),
			('Barbie', false, 'Brinquedos', '3', null),
			('ZIGS', false, 'Vestimenta', '5', null),
			('Bicicleta', false, 'Eletrônico', '4', null),
			('Cuturno', false, 'Móveis', '3', '3x57x80');
-- **********************
select*from orders;
-- delete from orders where idOrderClient in (1, 2, 3, 4);
insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
		(1, default, 'compra no app', null, 1),
		(2, default, 'compra no app', 50, 0),
		(3, 'Confirmado', null, null, 1),
		(4, default, 'compra no web site', 150, 0);
-- **********************          
select*from productOrder;
select*from produto;
insert into productOrder(idPOproduct, idPOorder, poQuantity, poStatus) 
		values (6, 6, 2, null),
			   (7, 7, 1, null),
			   (8, 8, 1, null);
-- **********************
select*from productStorage;
insert into productStorage (storageLocation, quantidade) values
	('Rio Janeiro', 1000),
	('Bataguassu', 500),
	('São Paulo', 10),
	('São Paulo', 100),
	('São Paulo', 10),
	('Brasília', 60);    
-- **********************
select*from storageLocation;
select*from produto;
insert into storageLocation(idLproduct, idLstorage, location) values
	(6, 3, 'RJ'),
    (7, 4, 'GO');
-- **********************
select*from supplier;
insert into supplier(SocialName, CNPJ, contato)
	values('almeida e filhos', 12313213, 32131321),
	('Eletrônicos Silva', 22313213, 32131321),
	('Eletrônicos Gabriel', 99313213, 44131321);
-- **********************
select*from seller;
insert into seller (SocialName, AbstName, CNPJ, CPF, location, contato) 
values('Tech eletronics', null, 123444556, null, 'Rio de Janeiro', 121331232),		
		('Casa de Pesca', null, 122444556, null, 'Rio de Janeiro', 23123213321),
        ('Dantas eletronics', null, 123213321, null, 'São Paulo', 3213133333);
-- **********************
select*from produtoSeller;
insert into produtoSeller (idProduto, prodQuantidade) values
	(1, 6, 80),
    (2, 7, 10);

-- querys minhas:

-- SELECTS Statement:
select * from clientes;
select * from orders;
select * from produto;
-- SELECT Statement e WHERE - aqui estou vendo os clientes que possuem idCliente maior que 2:
select idCliente, Fname, CPF from clientes where idCliente > 2;
-- SELECT Statement e WHERE - aqui estou vendo os clientes que possuem idCliente menor que 4:
select idCliente, Fname, CPF from clientes where idCliente < 4;
-- SELECT Statement e WHERE- aqui estou vendo os produtos que possuem a mesma categoria='Eletrônico':
select idProduto, Pname, categoria from produto p where p.categoria = 'Eletrônico';
-- Criação de expressões para gerar atributos derivados:
select * from productorder;
select * from productstorage;
select * from produtoseller;
select * from storagelocation;
select * from clientes;
select * from orders;
select * from produto;
select * from seller;
select * from supplier;

-- Utilizando a tabela cliente - concatenando o primeiro e o ultimo nome dos clientes:
SELECT idCliente, Fname, CONCAT(Fname, ' ', Lname) AS nome_completo
FROM clientes;
-- produtos de mesma avaliação e categoria;
SELECT idProduto, concat(categoria, ' ', avaliacao) as produto_de_mesma_categoria_e_avaliacao from produto p;
-- empresa junto com o seu telefone de contato:
SELECT idSupplier, concat(SocialName, ' ', contato) as Empresa_e_Telefone_para_Contato from supplier s;

-- order by:

-- produtos com avaliação menor ou igual a 4 e em ordem de nome: Pname;
select Pname, idProduto, avaliacao from produto p where p.avaliacao <= 4 order by p.Pname;
-- supplier com avaliação menor que 3 e em ordem de Socialname;
select SocialName, idSupplier from supplier s where s.idSupplier < 3 order by s.SocialName;
-- supplier com avaliação menor que 3 e em ordem de id: idSupplier;
select idSupplier, SocialName from supplier s where s.idSupplier < 3 order by s.idSupplier;

select * from productorder;
select * from productstorage;
select * from produtoseller;
select * from storagelocation;
select * from clientes;
select * from orders;
select * from produto;
select * from seller;
select * from supplier;

-- having Statement:
-- aqui estou checando os clientes que fizeram no maximo 3 pedidos:
SELECT idOrderClient, COUNT(*) AS num_orders
FROM orders
GROUP BY idOrderClient
HAVING COUNT(*) <= 3;

-- aqui voce encontra produtos da categoria "Eletrônico" com uma avaliação média superior a 3.:
SELECT categoria, AVG(avaliacao) AS avg_rating
FROM produto
WHERE categoria = 'Eletrônico'
GROUP BY categoria
HAVING AVG(avaliacao) > 3;

-- JOIN's:
-- Encontra produtos da categoria "Brinquedos" com uma avaliação média superior ou igual a 3.
SELECT p.Pname, p.categoria, AVG(p.avaliacao) AS media_da_avaliacao
FROM produto p
JOIN produtoSeller ps ON p.idProduto = ps.idProduto
WHERE p.categoria = 'Brinquedos'
GROUP BY p.Pname, p.categoria
HAVING AVG(p.avaliacao) >= 3;

select * from produto;
select * from produtoseller;

-- Encontrar vendedores (sellers) que tenham um total de quantidade de produtos (prodQuantidade) vendidos maior ou igual a 50
SELECT s.idSeller, s.SocialName, SUM(ps.prodQuantidade) AS total_quantity_sold
FROM seller s
JOIN produtoSeller ps ON s.idSeller = ps.idPseller
GROUP BY s.idSeller, s.SocialName
HAVING SUM(ps.prodQuantidade) >= 50;

-- Encontrar vendedores (sellers) que tenham um total de quantidade de produtos (prodQuantidade) vendidos menor ou igual a 50
SELECT s.idSeller, s.SocialName, SUM(ps.prodQuantidade) AS total_quantity_sold
FROM seller s
JOIN produtoSeller ps ON s.idSeller = ps.idPseller
GROUP BY s.idSeller, s.SocialName
HAVING SUM(ps.prodQuantidade) <= 50;

select * from seller;
select * from produtoseller;
