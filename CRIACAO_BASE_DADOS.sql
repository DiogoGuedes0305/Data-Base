-- ** eliminar tabelas se existentes **
-- CASCADE CONSTRAINTS para eliminar as restrições de integridade das chaves primárias e chaves únicas
-- PURGE elimina a tabela da base de dados e da "reciclagem"
DROP TABLE veiculos             CASCADE CONSTRAINTS PURGE;
DROP TABLE veiculos_condutores  CASCADE CONSTRAINTS PURGE;
DROP TABLE condutores           CASCADE CONSTRAINTS PURGE;
DROP TABLE viagens              CASCADE CONSTRAINTS PURGE;
DROP TABLE pedidos_viagens      CASCADE CONSTRAINTS PURGE;
DROP TABLE servicos             CASCADE CONSTRAINTS PURGE;
DROP TABLE itenerarios_viagens  CASCADE CONSTRAINTS PURGE;
DROP TABLE pontos_turisticos    CASCADE CONSTRAINTS PURGE;
DROP TABLE custos_servicos      CASCADE CONSTRAINTS PURGE;
DROP TABLE resumos_Veiculos     CASCADE CONSTRAINTS PURGE;


-- ** CRIAR TABELAS **

-- ## tabela Veiculos ##
CREATE TABLE veiculos (
    matricula       CHAR(8)                 CONSTRAINT pk_veiculos_matricula          PRIMARY KEY,                            
    marca           VARCHAR(40)             CONSTRAINT nn_veiculos_marca              NOT NULL,
    modelo          VARCHAR(20)             CONSTRAINT nn_veiculos_modelo             NOT NULL,
    nr_chassis      INTEGER                 CONSTRAINT nn_veiculos_nr_chassis         NOT NULL,
                                            CONSTRAINT un_veiculos_nr_chassis         UNIQUE(nr_chassis),
    data_matricula  DATE                    CONSTRAINT nn_veiculos_data_matricula     NOT NULL,
    CONSTRAINT ck_veiculos_matricula CHECK (REGEXP_LIKE(matricula, '[0-9]{2}-[A-Z]{2}-[0-9]{2}|[0-9]{2}-[0-9]{2}-[A-Z]{2}|[A-Z]{2}-[0-9]{2}-[0-9]{2}'))
);

-- ## tabela Veiculos Condutores ##                          
CREATE TABLE veiculos_condutores (
    matricula               CHAR(8),
    nr_idCivil              INTEGER,
    data_inicio             DATE,
    data_fim                DATE            CONSTRAINT nn_veiculos_condutores_data_fim                                      NOT NULL,    
    CONSTRAINT pk_veiculos_condutores_matricula_nr_idCivil      PRIMARY KEY (matricula, nr_idCivil, data_inicio)    
);

-- ## tabela Condutores ##
CREATE TABLE condutores (
    nr_idCivil                      INTEGER                         CONSTRAINT pk_condutores_nr_idCivil                     PRIMARY KEY,                      
    nr_idCivil_supervisor           INTEGER,
    nome                            VARCHAR(40)                     CONSTRAINT nn_condutores_nome                           NOT NULL,
    data_nascimento                 DATE                            CONSTRAINT nn_condutores_data_nascimento                NOT NULL,
    nr_carta_conducao               VARCHAR(40)                     CONSTRAINT nn_condutores_nr_carta_conducao              NOT NULL,
                                                                    CONSTRAINT un_condutores_nr_carta_conducao              UNIQUE(nr_carta_conducao),
    data_validade_carta_conducao    DATE                            CONSTRAINT nn_condutores_data_validade_carta_conducao   NOT NULL
);

-- ## tabela Viagens ##
CREATE TABLE viagens (
    cod_viagem                      INTEGER,
    cod_pedido                      INTEGER,            
    atraso_passageiros_minutos      NUMERIC(5,2)            CONSTRAINT nn_viagens_atraso_passageiros_minutos                NOT NULL,
    duracao_minutos                 NUMERIC(5,2)            CONSTRAINT nn_viagens_duracao_minutos                           NOT NULL,    
    CONSTRAINT pk_viagens_cod_viagem                        PRIMARY KEY(cod_viagem)
);

-- ## tabela Pedidos Viagens ##
CREATE TABLE pedidos_viagens(
    cod_pedido                      INTEGER                 CONSTRAINT pk_pedidos_viagens_cod_pedido                        PRIMARY KEY,
    matricula                       CHAR(8),
    nr_idCivil                      INTEGER,
    data_inicio                     DATE,
    cod_servico                     INTEGER,
    data_hora_pedido                DATE                    CONSTRAINT nn_pedidos_viagens_data_hora_pedido                  NOT NULL,
                                                            CONSTRAINT ck_pedidos_viagens_data_hora_pedido                  CHECK(data_hora_pedido < data_hora_recolha_passageiro),
    data_hora_recolha_passageiro    DATE                    CONSTRAINT nn_pedidos_viagens_data_hora_recolha_passageiro      NOT NULL,
    distancia_km                    INTEGER                 CONSTRAINT nn_pedidos_viagens_distancia_km                      NOT NULL,
    cancelado                       CHAR(3)                 CONSTRAINT ck_pedidos_viagens_cancelado                         CHECK(REGEXP_LIKE(cancelado,'SIM|NAO'))    
);


-- ## tabela Serviço ##
CREATE TABLE servicos (
    cod_servico                     INTEGER              CONSTRAINT pk_servicos_cod_servico                             PRIMARY KEY,
    descricao                       VARCHAR(40)          CONSTRAINT nn_servicos_descricao                               NOT NULL    
);


-- ## tabela Itenerarios Viagens ##
CREATE TABLE itenerarios_viagens(    
    cod_viagem                          INTEGER,
    cod_ponto_turistico                 INTEGER,
    hora_passagem                       TIMESTAMP         CONSTRAINT nn_itenerarios_viagens_hora_passagem             NOT NULL 

);

-- ## tabela Pontos Turisticos ##
CREATE TABLE pontos_turisticos(    
    cod_ponto_turistico                 INTEGER             CONSTRAINT pk_pontos_turisticos_cod_ponto_turistico         PRIMARY KEY,
    nome_ponto_turistico                VARCHAR(40)         CONSTRAINT nn_pontos_turisticos_nome_ponto_turistico        NOT NULL,
    tipo_ponto_turistico                VARCHAR(2)          CONSTRAINT ck_pontos_turisticos_tipo_ponto_turistico        CHECK(REGEXP_LIKE(tipo_ponto_turistico,'M|MU|PN|MI'))
);

-- ## tabela Custos Servicos ##
CREATE TABLE custos_servicos (
    cod_servico                     INTEGER,      
    data_ultima_atualizacao         DATE,
    data_inicio_custo               INTEGER              CONSTRAINT nn_custos_servicos_data_inicio_custo                 NOT NULL,
    data_fim_custo                  INTEGER              CONSTRAINT nn_custos_servicos_data_fim_custo                    NOT NULL,
    preco_base                      INTEGER              CONSTRAINT nn_custos_servicos_preco_base                        NOT NULL,
    custo_minuto                    INTEGER              CONSTRAINT nn_custos_servicos_custo_minuto                      NOT NULL,
    custo_km                        INTEGER              CONSTRAINT nn_custos_servicos_custo_km                          NOT NULL,
    taxa_IVA                        NUMERIC(5,2)         CONSTRAINT nn_custos_servicos_taxa_IVA                          NOT NULL,
    tempo_maximo_espera_minutos     NUMERIC(5,2)         CONSTRAINT nn_custos_servicos_tempo_maximo_espera_minutos       NOT NULL,
    custo_espera_minutos            INTEGER              CONSTRAINT nn_custos_servicos_custo_espera_minutos              NOT NULL,
    custo_cancelamento_pedido       INTEGER              CONSTRAINT nn_custos_servicos_custo_cancelamento_pedido         NOT NULL,    
    CONSTRAINT pk_custos_servicos_cod_servico_data_inicio_custo PRIMARY KEY(cod_servico, data_inicio_custo)
);

-- ## tabela Resumos Veiculos  ##
CREATE TABLE resumos_Veiculos (
    instante TIMESTAMP       CONSTRAINT nn_resumos_veiculos_instante NOT NULL,
    data_inicio DATE         CONSTRAINT nn_resumos_veiculos_data_inicio NOT NULL,
    data_fim DATE            CONSTRAINT nn_resumos_veiculos_data_fim NOT NULL,
                             CONSTRAINT ck_resumos_veiculos_data_fim CHECK (data_fim > data_inicio),
    matricula VARCHAR2(8)    CONSTRAINT nn_resumos_veiculos_matricula NOT NULL,
                             CONSTRAINT ck_veiculos_matricula CHECK (REGEXP_LIKE(matricula, '[0-9]{2}-[A-Z]{2}-[0-9]{2}|[0-9]{2}-[0-9]{2}-[A-Z]{2}|[A-Z]{2}-[0-9]{2}-[0-9]{2}')),
    nr_viagens INTEGER       CONSTRAINT ck_resumos_veiculos_nr_viagens CHECK ( nr_viagens > 0 ),
    soma_km INTEGER          CONSTRAINT ck_resumos_veiculos_soma_km CHECK ( soma_km > 0 ),
    soma_duracao INTEGER     CONSTRAINT ck_resumos_veiculos_soma_duracao CHECK ( soma_duracao > 0 ),
    
    CONSTRAINT pk_resumos_veiculos_data_inicio_data_fim_matricula PRIMARY KEY (matricula, data_inicio, data_fim)
);

-- ** alterar tabelas para definição de chaves estrangeiras **
ALTER TABLE veiculos_condutores         ADD CONSTRAINT fk_veiculos_condutores_matricula         FOREIGN KEY (matricula)                            REFERENCES veiculos (matricula);
ALTER TABLE veiculos_condutores         ADD CONSTRAINT fk_veiculos_condutores_nr_idCivil        FOREIGN KEY (nr_idCivil)                           REFERENCES condutores (nr_idCivil);
ALTER TABLE condutores                  ADD CONSTRAINT fk_condutores_nr_idCivil_supervisor      FOREIGN KEY (nr_idCivil_supervisor)                REFERENCES condutores (nr_idCivil);
ALTER TABLE pedidos_viagens             ADD CONSTRAINT fk_pedidos_viagens_matricula             FOREIGN KEY (matricula)                            REFERENCES veiculos(matricula);
ALTER TABLE pedidos_viagens             ADD CONSTRAINT fk_pedidos_viagens_nr_idCivil            FOREIGN KEY (nr_idCivil)                           REFERENCES condutores(nr_idCivil);
ALTER TABLE pedidos_viagens             ADD CONSTRAINT fk_pedidos_viagens_data_inicio           FOREIGN KEY (matricula, nr_idCivil, data_inicio)   REFERENCES veiculos_condutores(matricula, nr_idCivil, data_inicio);
ALTER TABLE custos_servicos             ADD CONSTRAINT fk_custos_servicos_cod_servico           FOREIGN KEY(cod_servico)                           REFERENCES servicos(cod_servico);

