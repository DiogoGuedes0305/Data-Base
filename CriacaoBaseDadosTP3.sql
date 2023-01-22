DROP TABLE Veiculos             CASCADE CONSTRAINTS PURGE;
DROP TABLE Veiculos_Condutores  CASCADE CONSTRAINTS PURGE;
DROP TABLE Condutores           CASCADE CONSTRAINTS PURGE;
DROP TABLE carta_conducao       CASCADE CONSTRAINTS PURGE;
DROP TABLE Veiculo_Chassis      CASCADE CONSTRAINTS PURGE;
DROP TABLE Chassis              CASCADE CONSTRAINTS PURGE;
DROP TABLE Modelo_Veiculo       CASCADE CONSTRAINTS PURGE;
DROP TABLE Recibo_Mes           CASCADE CONSTRAINTS PURGE;
DROP TABLE Recibo_Viagem        CASCADE CONSTRAINTS PURGE;
DROP TABLE Viagens              CASCADE CONSTRAINTS PURGE;
DROP TABLE Pedidos_Viagens      CASCADE CONSTRAINTS PURGE;
DROP TABLE Servico              CASCADE CONSTRAINTS PURGE;
DROP TABLE Tipo_Servico         CASCADE CONSTRAINTS PURGE;
DROP TABLE Percentagem_Condutor CASCADE CONSTRAINTS PURGE;
DROP TABLE Login                CASCADE CONSTRAINTS PURGE;
DROP TABLE Login_Cliente        CASCADE CONSTRAINTS PURGE;
DROP TABLE Cliente              CASCADE CONSTRAINTS PURGE;
DROP TABLE Fatura               CASCADE CONSTRAINTS PURGE;
DROP TABLE Itenerarios_Viagens  CASCADE CONSTRAINTS PURGE;
DROP TABLE Ponto_Turistico      CASCADE CONSTRAINTS PURGE;
DROP TABLE Custos_Servicos      CASCADE CONSTRAINTS PURGE;
DROP TABLE Tipo_Ponto_Turistico CASCADE CONSTRAINTS PURGE;


CREATE TABLE Veiculos_Condutores (
matricula char(8) NOT NULL,
nr_idCivil number(8) NOT NULL, 
data_inicio TIMESTAMP NOT NULL, 
data_fim TIMESTAMP, 
PRIMARY KEY (matricula, nr_idCivil, data_inicio));


CREATE TABLE Condutores (
nr_idCivil number(8), 
nr_idCivil_supervisor number(8), 
nr_cartaConducao number(8) NOT NULL, 
nome varchar2(40) NOT NULL, 
data_nascimento date NOT NULL, 
nr_contribuinte number(9) NOT NULL,
morada varchar(60) NOT NULL, 
PRIMARY KEY (nr_idCivil));


CREATE TABLE carta_conducao (
nr_cartaConducao number(8), 
data_validade_cartaConducao date NOT NULL, 
PRIMARY KEY (nr_cartaConducao));


CREATE TABLE Veiculos (
matricula char(8) NOT NULL, 
data_matricula date NOT NULL,
kms_percorridos float(10) NOT NULL, 
kms_semanais float(10) NOT NULL, 
PRIMARY KEY (matricula));
 
 
CREATE TABLE Veiculo_Chassis (
matricula char(8) NOT NULL, 
nr_chassis varchar(20) NOT NULL, 
CONSTRAINT pk_Veiculo_Chassis_matricula_nr_chassis PRIMARY KEY (matricula, nr_chassis));


CREATE TABLE Chassis (
nr_chassis varchar(20) NOT NULL, 
modelo varchar(10) NOT NULL, 
PRIMARY KEY (nr_chassis));


CREATE TABLE Modelo_Veiculo (
modelo varchar2(10) NOT NULL,
marca varchar2(10) NOT NULL, 
PRIMARY KEY (modelo));


CREATE TABLE Recibo_Mes (
nr_recibo_mes number(10),
nr_idCivil_Condutor number(8) NOT NULL, 
valor_total_comissoes float(10) NOT NULL, 
data_emissao date NOT NULL, 
PRIMARY KEY (nr_recibo_mes));


CREATE TABLE Recibo_Viagem (
nr_recibo number(10) NOT NULL, 
nr_recibo_mes number(10) NOT NULL, 
cod_tipo_servico number(10) NOT NULL, 
cod_viagem number(10) NOT NULL, 
nr_idCivil_Condutor number(8) NOT NULL, 
percentagem_viagem number(3, 2) NOT NULL, 
comissao_tipo_servico float(10) NOT NULL, 
PRIMARY KEY (nr_recibo, nr_recibo_mes, cod_tipo_servico));


CREATE TABLE Viagens (
cod_viagem number(10),
cod_pedido number(10) NOT NULL, 
duracao_minutos timestamp(9) NOT NULL, 
atraso_passageiros_minutos timestamp(9), 
local_inicio varchar2(40) NOT NULL, 
PRIMARY KEY (cod_viagem));


CREATE TABLE Pedidos_Viagens (
cod_pedido number(10),
matricula char(8), 
nr_idCivil_Condutor number(8), 
data_inicio date, 
cod_servico number(10) NOT NULL, 
login_Cliente varchar2(20) NOT NULL, 
data_hora_pedido date NOT NULL,
data_hora_recolha_passageiro date NOT NULL,
distancia_km number(10) NOT NULL,
estimativa_duracao integer NOT NULL,
PRIMARY KEY (cod_pedido));


CREATE TABLE Servico (
cod_servico number(10),
cod_tipo_servico number(10) NOT NULL, 
PRIMARY KEY (cod_servico));


CREATE TABLE Tipo_Servico (
cod_tipo_servico number(10), 
descricao varchar2(30) NOT NULL, 
custo_cancelamento float(5) NOT NULL,
percentagem_comissao_supervisor number(3, 2) NOT NULL,
PRIMARY KEY (cod_tipo_servico));


CREATE TABLE Percentagem_Condutor (
percentagem_comissao_condutor number(3, 2) NOT NULL,
cod_tipo_servico number(10) NOT NULL, 
PRIMARY KEY (percentagem_comissao_condutor, cod_tipo_servico));


CREATE TABLE Login (
login varchar2(20) NOT NULL,
passwordCliente varchar2(20) NOT NULL,
PRIMARY KEY (login));


CREATE TABLE Login_Cliente (
login varchar(20) NOT NULL,
nr_idCivil_Cliente number(8) NOT NULL, 
PRIMARY KEY (login, nr_idCivil_Cliente));


CREATE TABLE Cliente (
nr_idCivil number(8),
nr_contribuinte number(9) NOT NULL, 
data_nascimento date NOT NULL,
nome varchar2(30) NOT NULL, 
morada varchar2(30) NOT NULL, 
PRIMARY KEY (nr_idCivil));


CREATE TABLE Fatura (
id_fatura number(10), 
cod_pedido number(10) NOT NULL, 
custo_viagem float(10) NOT NULL, 
data_emissao date NOT NULL, 
nr_idCivil_Cliente number(8) NOT NULL, 
PRIMARY KEY (id_fatura));


CREATE TABLE Custos_Servicos (
data_inicio_custo date NOT NULL, 
cod_servico number(10) NOT NULL, 
data_fim_custo date NOT NULL, 
preco_base float(10) NOT NULL, 
custo_minuto float(10) NOT NULL, 
custo_km float(10) NOT NULL, 
tempo_maximo_espera_minutos timestamp(5) NOT NULL,
custo_espera_minutos float(10) NOT NULL, 
taxa_iva number(3, 2) NOT NULL, 
PRIMARY KEY (data_inicio_custo, cod_servico));


CREATE TABLE Itenerarios_Viagens (
cod_viagem number(10) NOT NULL, 
cod_ponto_turistico number(10) NOT NULL,
hora_passagem timestamp(0) NOT NULL, 
PRIMARY KEY (cod_viagem, cod_ponto_turistico));


CREATE TABLE Ponto_Turistico (
cod_ponto_turistico number(10), 
cod_tipo_ponto_turistico char(2) NOT NULL, 
nome_ponto_turistico varchar2(20) NOT NULL,
PRIMARY KEY (cod_ponto_turistico));


CREATE TABLE Tipo_Ponto_Turistico (
cod_tipo_ponto_turistico char(2) NOT NULL, 
PRIMARY KEY (cod_tipo_ponto_turistico));

ALTER TABLE Condutores ADD CONSTRAINT FKCondutores723626 FOREIGN KEY (nr_cartaConducao) REFERENCES carta_conducao (nr_cartaConducao);

ALTER TABLE Veiculos_Condutores ADD CONSTRAINT FKVeiculos_C319860 FOREIGN KEY (nr_idCivil) REFERENCES Condutores (nr_idCivil);

ALTER TABLE Veiculos_Condutores ADD CONSTRAINT FKVeiculos_C213623 FOREIGN KEY (matricula) REFERENCES Veiculos (matricula);

ALTER TABLE Veiculo_Chassis ADD CONSTRAINT FKVeiculo_Ch917876 FOREIGN KEY (matricula) REFERENCES Veiculos (matricula);

ALTER TABLE Veiculo_Chassis ADD CONSTRAINT FKVeiculo_Ch679051 FOREIGN KEY (nr_chassis) REFERENCES Chassis (nr_chassis);

ALTER TABLE Chassis ADD CONSTRAINT FKChassis68072 FOREIGN KEY (modelo) REFERENCES Modelo_Veiculo (modelo);

ALTER TABLE Recibo_Viagem ADD CONSTRAINT FKRecibo_Via666278 FOREIGN KEY (nr_idCivil_Condutor) REFERENCES Condutores (nr_idCivil);

ALTER TABLE Recibo_Viagem ADD CONSTRAINT FKRecibo_Via460024 FOREIGN KEY (nr_recibo_mes) REFERENCES Recibo_Mes (nr_recibo_mes);

ALTER TABLE Recibo_Mes ADD CONSTRAINT FKRecibo_Mes321326 FOREIGN KEY (nr_idCivil_Condutor) REFERENCES Condutores (nr_idCivil);

--ALTER TABLE Pedidos_Viagens ADD CONSTRAINT FKPedidos_Vi102435 FOREIGN KEY (matricula, nr_idCivil_Condutor, data_inicio) REFERENCES Veiculos_Condutores (matricula, nr_idCivil, data_inicio);

ALTER TABLE Viagens ADD CONSTRAINT FKViagens190504 FOREIGN KEY (cod_pedido) REFERENCES Pedidos_Viagens (cod_pedido);

ALTER TABLE Recibo_Viagem ADD CONSTRAINT FKRecibo_Via692566 FOREIGN KEY (cod_viagem) REFERENCES Viagens (cod_viagem);

ALTER TABLE Pedidos_Viagens ADD CONSTRAINT FKPedidos_Vi418493 FOREIGN KEY (cod_servico) REFERENCES Servico (cod_servico);

ALTER TABLE Servico ADD CONSTRAINT FKServico248089 FOREIGN KEY (cod_tipo_servico) REFERENCES Tipo_Servico (cod_tipo_servico);

ALTER TABLE Percentagem_Condutor ADD CONSTRAINT FKPercentage879076 FOREIGN KEY (cod_tipo_servico) REFERENCES Tipo_Servico (cod_tipo_servico);

ALTER TABLE Recibo_Viagem ADD CONSTRAINT FKRecibo_Via675594 FOREIGN KEY (percentagem_viagem, cod_tipo_servico) REFERENCES Percentagem_Condutor (percentagem_comissao_condutor, cod_tipo_servico);

ALTER TABLE Login_Cliente ADD CONSTRAINT FKLogin_Clie909089 FOREIGN KEY (login) REFERENCES Login (login);

ALTER TABLE Login_Cliente ADD CONSTRAINT FKLogin_Clie762017 FOREIGN KEY (nr_idCivil_Cliente) REFERENCES Cliente (nr_idCivil);

ALTER TABLE Fatura ADD CONSTRAINT FKFatura667728 FOREIGN KEY (cod_pedido) REFERENCES Pedidos_Viagens (cod_pedido);

ALTER TABLE Fatura ADD CONSTRAINT FKFatura420779 FOREIGN KEY (nr_idCivil_Cliente) REFERENCES Cliente (nr_idCivil);

ALTER TABLE Custos_Servicos ADD CONSTRAINT FKCustos_Ser314170 FOREIGN KEY (cod_servico) REFERENCES Servico (cod_servico);

ALTER TABLE Pedidos_Viagens ADD CONSTRAINT FKPedidos_Vi767917 FOREIGN KEY (login_Cliente) REFERENCES Login (login);

ALTER TABLE Itenerarios_Viagens ADD CONSTRAINT FKItenerario440740 FOREIGN KEY (cod_viagem) REFERENCES Viagens (cod_viagem);

ALTER TABLE Itenerarios_Viagens ADD CONSTRAINT FKItenerario335548 FOREIGN KEY (cod_ponto_turistico) REFERENCES Ponto_Turistico (cod_ponto_turistico);

ALTER TABLE Ponto_Turistico ADD CONSTRAINT FKPonto_Turi514698 FOREIGN KEY (cod_tipo_ponto_turistico) REFERENCES Tipo_Ponto_Turistico (cod_tipo_ponto_turistico);
