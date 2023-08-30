create database locadora_de_veiculos;
use locadora_de_veiculos;

-- Tabela para armazenar informações dos clientes
CREATE TABLE Clientes (
    cliente_id INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    telefone VARCHAR(15),
    endereco VARCHAR(200)
);
desc clientes;

-- Tabela para armazenar informações dos veículos
CREATE TABLE Veiculos (
    veiculo_id INT PRIMARY KEY,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    ano INT,
    disponivel BOOLEAN
);
desc Veiculos;

-- Tabela para armazenar informações das reservas
CREATE TABLE Reservas (
    reserva_id INT PRIMARY KEY,
    cliente_id INT,
    veiculo_id INT,
    data_inicio DATE,
    data_fim DATE,
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (veiculo_id) REFERENCES Veiculos(veiculo_id)
);
desc Reservas;

-- Tabela para armazenar informações dos funcionários
CREATE TABLE Funcionarios (
    funcionario_id INT PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50),
    salario DECIMAL(10, 2)
);
desc Funcionarios;

-- INSERÇÕES:
-- TABELA CLIENTE:
INSERT INTO Clientes (cliente_id, nome, email, telefone, endereco)
VALUES
    (1, 'João Silva', 'joao@email.com', '123456789', 'Rua A, 123'),
    (2, 'Ana Rodrigues', 'ana@email.com', '987654321', 'Avenida B, 456'),
    (3, 'Pedro Santos', 'pedro@email.com', '555555555', 'Rua C, 789'),
    (4, 'Lúcia Lima', 'lucia@email.com', '111222333', 'Rua D, 101'),
    (5, 'Carlos Oliveira', 'carlos@email.com', '444333222', 'Avenida E, 202');
    
-- TABELA VEICULOS:
INSERT INTO Veiculos (veiculo_id, modelo, marca, ano, disponivel)
VALUES
    (1, 'Sedan', 'Toyota', 2023, 1),
    (2, 'SUV', 'Honda', 2022, 1),
    (3, 'Hatchback', 'Volkswagen', 2023, 1),
    (4, 'Sedan', 'Nissan', 2022, 0),
    (5, 'SUV', 'Ford', 2023, 1);

-- TABELA RESERVAS:
INSERT INTO Reservas (reserva_id, cliente_id, veiculo_id, data_inicio, data_fim)
VALUES
    (1, 1, 2, '2023-09-01', '2023-09-10'),
    (2, 3, 1, '2023-08-15', '2023-08-20'),
    (3, 2, 3, '2023-09-05', '2023-09-12'),
    (4, 4, 5, '2023-08-25', '2023-09-03'),
    (5, 5, 4, '2023-09-10', '2023-09-18');

-- TABELA FUNCIONARIOS:
INSERT INTO Funcionarios (funcionario_id, nome, cargo, salario)
VALUES
    (1, 'Maria Santos', 'Atendente', 2500.00),
    (2, 'André Lima', 'Gerente', 4000.00),
    (3, 'Carla Fernandes', 'Atendente', 2300.00),
    (4, 'Rafael Oliveira', 'Motorista', 2800.00),
    (5, 'Ana Rodrigues', 'Atendente', 2400.00);

show tables;

-- SELECT's Statement's:
-- Recuperar todos os clientes - só select*from:
SELECT * FROM Clientes;

-- Recuperar todos os veículos
SELECT * FROM Veiculos;

-- Recuperar todas as reservas
SELECT * FROM Reservas;

-- Recuperar todos os funcionários
SELECT * FROM Funcionarios;

-- WHERE's:
-- Recuperar veículos disponíveis - WHERE:
SELECT * FROM Veiculos WHERE disponivel = 1;

-- Recuperar reservas de um cliente específico
SELECT * FROM Reservas WHERE cliente_id = 2;

-- Recuperar funcionários com salário acima de $2000
SELECT * FROM Funcionarios WHERE salario > 2000;

-- ATRIBUTOS DERIVADOS:
-- Recuperar nome dos clientes jjunto com seus telefones -- Atributos derivados:
SELECT CONCAT(nome, '/ telefone:', telefone) AS nome_e_contato FROM Clientes;

-- Calcular a duração da reserva em dias
SELECT reserva_id, DATEDIFF(data_fim, data_inicio) AS duracao_dias FROM Reservas;

-- ORDER BY:
-- Recuperar veículos ordenados por ano
SELECT * FROM Veiculos ORDER BY ano DESC;

-- Recuperar funcionários ordenados por salário em ordem crescente
SELECT * FROM Funcionarios ORDER BY salario;

-- HAVING
-- Recuperar o total de reservas por cliente com menos de 2 reservas -- HAVING:
SELECT cliente_id, COUNT(*) AS total_reservas
FROM Reservas
GROUP BY cliente_id
HAVING total_reservas < 2;

-- HAVING para filtrar funcionários que têm uma média salarial acima de um determinado valor:
SELECT F.nome, AVG(F.salario) AS media_salario
FROM Funcionarios F
GROUP BY F.nome
HAVING media_salario > 2500;

-- JOIN's:
-- aqui ele esta buscando uma coluna de cada tabela menos da tabela Funcionários: 
SELECT R.reserva_id, C.nome AS nome_cliente, V.modelo
FROM Reservas R
JOIN Clientes C ON R.cliente_id = C.cliente_id
JOIN Veiculos V ON R.veiculo_id = V.veiculo_id;

-- aqui na jounção entre as tabelas Veiculos e Clientes ele está agrupando pelo modelo do veiculo e contando
-- quantos clientes diferentes fizeram reservas para cada modelo: 
SELECT V.modelo, COUNT(DISTINCT R.cliente_id) AS total_clientes
FROM Veiculos V
JOIN Reservas R ON V.veiculo_id = R.veiculo_id
GROUP BY V.modelo
ORDER BY total_clientes DESC;

select*from veiculos;
select*from reservas;

