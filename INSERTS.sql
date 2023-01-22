-- ## Insert to Veiculos ##
INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula)
VALUES('45-XX-98', 'Toyota', 'yaris', 2000, TO_DATE('1999/06/24', 'YYYY/MM/DD'));

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula)
VALUES('15-WW-12', 'Toyota', 'Camry', 2001, TO_DATE('1986/10/18', 'YYYY/MM/DD'));

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula)
VALUES('56-ZD-18', 'Mercedes', 'AMG', 2002, TO_DATE('2007/08/04', 'YYYY/MM/DD'));

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula)
VALUES('05-PP-90', 'Tesla', 'Model S', 2003, TO_DATE('2017/12/30', 'YYYY/MM/DD'));

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula)
VALUES('15-EQ-18', 'Opel', 'Corsa', 2004, TO_DATE('2017/11/30', 'YYYY/MM/DD'));  

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula)
VALUES('01-MN-01', 'Ferrari', '488', 2005, TO_DATE('1999/03/05', 'YYYY/MM/DD'));

INSERT INTO veiculos(matricula, marca, modelo, nr_chassis, data_matricula)
VALUES('99-AA-99', 'Fiat', '500', 2006, TO_DATE('2019/2/4', 'YYYY/MM/DD'));

----------------------------                          


SELECT * FROM veiculos;


-- ## Insert to Condutores ##
INSERT INTO condutores(nr_idCivil, nr_idCivil_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao)
VALUES(152594660, NULL, 'Pedro Carneiro', TO_DATE('26-05-1999', 'dd-mm-yyyy'), 'P-1702118 1',TO_DATE('26-03-2018', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil, nr_idCivil_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao)
VALUES(199999999, 152594660, 'Esteves Malandreco',TO_DATE('18-02-1987', 'dd-mm-yyyy'), 'P-1502118 5',TO_DATE('18-05-2017', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil, nr_idCivil_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao)
VALUES(188888888, 152594660, 'Hernaldo Zafit', TO_DATE('18-05-2017', 'dd-mm-yyyy'), 'P-1711111 2',TO_DATE('02-12-2031', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil, nr_idCivil_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao)
VALUES(177777777, 152594660, 'Josefino Jose',TO_DATE('21-05-1930', 'dd-mm-yyyy'), 'P-1880018 1',TO_DATE('17-07-2017', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil, nr_idCivil_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao)
VALUES(108888888, 152594660, 'Jaqueline Zuzu', TO_DATE('30-05-1981', 'dd-mm-yyyy'), 'P-1702003 2',TO_DATE('12-01-2019', 'dd-mm-yyyy'));   

INSERT INTO condutores(nr_idCivil, nr_idCivil_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao)
VALUES(111111777, 152594660, 'Bruno Cerqueira', TO_DATE('04-04-2001', 'dd-mm-yyyy'), 'P-1000118 1',TO_DATE('11-12-2026', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil, nr_idCivil_supervisor, nome, data_nascimento, nr_carta_conducao, data_validade_carta_conducao)
VALUES(177775555, 152594660, 'Romeo Julieta' ,TO_DATE('07-08-1989', 'dd-mm-yyyy'), 'P-1234567 8',TO_DATE('04-04-2001', 'dd-mm-yyyy'));      


SELECT * FROM condutores;


-- ## Insert to Veiculos Condutores ##
INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('45-XX-98', 152594660, TO_DATE('26-04-2008', 'dd-mm-yyyy'),TO_DATE('26-04-2008', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('45-XX-98', 152594660, TO_DATE('26-10-2008', 'dd-mm-yyyy'),TO_DATE('26-10-2008', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('45-XX-98', 152594660, TO_DATE('21-01-2008', 'dd-mm-yyyy'),TO_DATE('21-01-2008', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('45-XX-98', 152594660,TO_DATE('19-04-2008', 'dd-mm-yyyy'),TO_DATE('19-04-2008', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('15-WW-12', 199999999, TO_DATE('25-07-2005', 'dd-mm-yyyy'),TO_DATE('25-07-2005', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('15-WW-12', 199999999, TO_DATE('16-08-2014', 'dd-mm-yyyy'),TO_DATE('16-08-2014', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('15-WW-12', 199999999, TO_DATE('17-08-2014', 'dd-mm-yyyy'),TO_DATE('17-08-2014', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('15-WW-12', 199999999, TO_DATE('01-01-2001', 'dd-mm-yyyy'),TO_DATE('01-01-2001', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('56-ZD-18', 188888888,TO_DATE('23-04-2008', 'dd-mm-yyyy') ,TO_DATE('23-04-2008', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('56-ZD-18', 188888888,TO_DATE('01-11-2001', 'dd-mm-yyyy') ,TO_DATE('01-11-2001', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('56-ZD-18', 188888888,TO_DATE('30-01-2001', 'dd-mm-yyyy') ,TO_DATE('30-01-2001', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('99-AA-99', 177777777,TO_DATE('18-08-2014', 'dd-mm-yyyy'),TO_DATE('18-08-2014', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('99-AA-99', 177777777,TO_DATE('19-08-2014', 'dd-mm-yyyy'),TO_DATE('19-08-2014', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('01-MN-01', 111111777,TO_DATE('29-04-2009', 'dd-mm-yyyy'),TO_DATE('29-04-2009', 'dd-mm-yyyy'));

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('01-MN-01', 111111777,TO_DATE('02-05-2009', 'dd-mm-yyyy'),TO_DATE('02-05-2009', 'dd-mm-yyyy'));   

INSERT INTO veiculos_condutores(matricula, nr_idcivil, data_inicio, data_fim)
VALUES('01-MN-01', 111111777,TO_DATE('17-07-2009', 'dd-mm-yyyy'),TO_DATE('17-07-2009', 'dd-mm-yyyy'));   


SELECT * FROM veiculos_condutores;



-- ## Insert to Viagens ##
INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(1,1,15, 60);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(2,2,30, 150);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(3,3,0, 180);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(4,4,12, 115);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(5,6,12, 150);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(6,7,0, 150);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(7,8,0, 75);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(8,9,12, 115);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(9,10,3, 45);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(10,11,7, 67);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(11,12,2, 210);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(12,13,5, 301);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(13,14,12, 45);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(14,15,3, 78);

INSERT INTO viagens(cod_viagem, cod_pedido, atraso_passageiros_minutos, duracao_minutos)
VALUES(15,16,1, 87);


SELECT * FROM viagens;


-- ## Insert to Servico ##
INSERT INTO servicos(cod_servico, descricao)
VALUES(1, 'Casual');

INSERT INTO servicos(cod_servico, descricao)
VALUES(2, 'Eco');

INSERT INTO servicos(cod_servico, descricao)
VALUES(3, 'Luxo');

INSERT INTO servicos(cod_servico, descricao)
VALUES(4, 'Grupo');

SELECT * FROM servicos;


-- ## Insert to Pedidos Viagens ##
INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(1, '45-XX-98', 111111777, TO_DATE('26-04-2008', 'dd-mm-yyyy'), 1, TO_TIMESTAMP('26/03/2007 16:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('26 22:35', 'dd hh24:mi'),30, 'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(2, '56-ZD-18', 188888888, TO_DATE('23-04-2008', 'dd-mm-yyyy'), 1, TO_TIMESTAMP('23/03/2008 16:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('23 22:35', 'dd hh24:mi'),40, 'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(3, '45-XX-98', 152594660,TO_DATE('26-10-2008', 'dd-mm-yyyy'), 1, TO_TIMESTAMP('26/09/1999 06:38',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('26 16:30', 'dd hh24:mi'),310, 'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(4, '45-XX-98', 111111777, TO_DATE('21-01-2008', 'dd-mm-yyyy'), 1, TO_TIMESTAMP('18/01/2008 16:35', 'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('21 22:35', 'dd hh24:mi'),30, 'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(5, '01-MN-01', 111111777, TO_DATE('29-04-2009', 'dd-mm-yyyy'), 2,  TO_TIMESTAMP('25/04/2009 09:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('29 16:35', 'dd hh24:mi'),250, 'SIM');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(6, '01-MN-01', 111111777, TO_DATE('02-05-2009', 'dd-mm-yyyy'), 2,  TO_TIMESTAMP('02/04/2009 09:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('02 16:35', 'dd hh24:mi'),220, 'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(7, '01-MN-01', 111111777, TO_DATE('17-07-2009', 'dd-mm-yyyy'), 2,  TO_TIMESTAMP('17/07/2008 09:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('17 16:35', 'dd hh24:mi'),123, 'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(8,'45-XX-98',152594660, TO_DATE('19-04-2008', 'dd-mm-yyyy'), 2, TO_TIMESTAMP('19/03/2008 09:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('19 16:35', 'dd hh24:mi'),250,'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(9,'15-WW-12', 199999999, TO_DATE('01-01-2001', 'dd-mm-yyyy'), 3, TO_TIMESTAMP('01/12/2000 12:30',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('01 16:45', 'dd hh24:mi'),60,'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(10, '56-ZD-18', 188888888, TO_DATE('01-11-2001', 'dd-mm-yyyy'), 3, TO_TIMESTAMP('01/10/2001 12:30',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('01 16:45', 'dd hh24:mi'),68,'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(11,'56-ZD-18', 188888888, TO_DATE('30-01-2001', 'dd-mm-yyyy'), 3, TO_TIMESTAMP('30/01/2019 12:30',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('30 16:45', 'dd hh24:mi'),250,'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(12, '15-WW-12', 199999999, TO_DATE('25-07-2005', 'dd-mm-yyyy'), 3, TO_TIMESTAMP('23/07/2005 12:30',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('25 16:45', 'dd hh24:mi'),47,'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(13, '15-WW-12', 188888888, TO_DATE('16-08-2014', 'dd-mm-yyyy'), 4, TO_TIMESTAMP('16/04/2014 06:00', 'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('16 19:15', 'dd hh24:mi'),125,'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(14, '15-WW-12', 188888888, TO_DATE('17-08-2014', 'dd-mm-yyyy'), 4, TO_TIMESTAMP('17/05/2019 06:00','dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('17 19:15', 'dd hh24:mi'),56,'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(15, '99-AA-99', 177777777, TO_DATE('18-08-2014', 'dd-mm-yyyy'), 4, TO_TIMESTAMP('18/06/2019 06:00', 'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('18 19:15', 'dd hh24:mi'),188,'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(16, '99-AA-99', 177777777, TO_DATE('19-08-2014', 'dd-mm-yyyy'), 4, TO_TIMESTAMP('19/07/2019 06:00', 'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('19 19:15', 'dd hh24:mi'),98,'NAO');

INSERT INTO pedidos_viagens(cod_pedido, matricula, nr_idcivil, data_inicio, cod_servico, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, cancelado)
VALUES(17, '99-AA-99', 177777777, TO_DATE('17-08-2014', 'dd-mm-yyyy'), 4, TO_TIMESTAMP('17/04/2019 06:00', 'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('17 19:15', 'dd hh24:mi'),97,'NAO' );


SELECT * FROM pedidos_viagens;


-- ## Insert to Pontos Turísticos ##
INSERT INTO pontos_turisticos(cod_ponto_turistico, nome_ponto_turistico, tipo_ponto_turistico)
VALUES(1,'Torre Eiffel','M');

INSERT INTO pontos_turisticos(cod_ponto_turistico, nome_ponto_turistico, tipo_ponto_turistico)
VALUES(2,'Museu de Historia Nacional','MU');

INSERT INTO pontos_turisticos(cod_ponto_turistico, nome_ponto_turistico, tipo_ponto_turistico)
VALUES(3,'Parque da Pedra','PN');

INSERT INTO pontos_turisticos(cod_ponto_turistico, nome_ponto_turistico, tipo_ponto_turistico)
VALUES(4,'Miradouro do Monte','MI');

INSERT INTO pontos_turisticos(cod_ponto_turistico, nome_ponto_turistico, tipo_ponto_turistico)
VALUES(5,'Estatua do Ardina','M');


SELECT * FROM pontos_turisticos;



-- ## Insert to Itenerários Viagens ##
INSERT INTO itenerarios_viagens(cod_viagem, cod_ponto_turistico, hora_passagem)
VALUES(1, 2, TO_TIMESTAMP('15','hh24'));

INSERT INTO itenerarios_viagens(cod_viagem, cod_ponto_turistico, hora_passagem)
VALUES(2, 3,TO_TIMESTAMP('16', 'hh24'));

INSERT INTO itenerarios_viagens(cod_viagem, cod_ponto_turistico, hora_passagem)
VALUES(3, 4,TO_TIMESTAMP('17','hh24'));

INSERT INTO itenerarios_viagens(cod_viagem, cod_ponto_turistico, hora_passagem)
VALUES(4, 5,TO_TIMESTAMP('18','hh24'));


SELECT * FROM itenerarios_viagens;


-- ## Insert to Custos Serviços ##
INSERT INTO custos_servicos(cod_servico, data_ultima_atualizacao, data_inicio_custo, data_fim_custo, preco_base, custo_minuto, custo_km, taxa_IVA, tempo_maximo_espera_minutos, custo_espera_minutos, custo_cancelamento_pedido)
VALUES(1,TO_DATE('03-04-2018', 'dd-mm-yyyy'),150, 200, 75, 5 ,5, 50, 15, 3, 25);

INSERT INTO custos_servicos(cod_servico, data_ultima_atualizacao, data_inicio_custo, data_fim_custo, preco_base, custo_minuto, custo_km, taxa_IVA, tempo_maximo_espera_minutos, custo_espera_minutos, custo_cancelamento_pedido)
VALUES(2,TO_DATE('21-04-2011', 'dd-mm-yyyy'),75, 100, 25, 3 ,3, 13, 15, 3, 25);

INSERT INTO custos_servicos(cod_servico, data_ultima_atualizacao, data_inicio_custo, data_fim_custo, preco_base, custo_minuto, custo_km, taxa_IVA, tempo_maximo_espera_minutos, custo_espera_minutos, custo_cancelamento_pedido)
VALUES(3,TO_DATE('17-03-2017', 'dd-mm-yyyy'),50, 65, 25, 5, 3, 8, 15, 1, 25);

INSERT INTO custos_servicos(cod_servico, data_ultima_atualizacao, data_inicio_custo, data_fim_custo, preco_base, custo_minuto, custo_km, taxa_IVA, tempo_maximo_espera_minutos, custo_espera_minutos, custo_cancelamento_pedido)
VALUES(4,TO_DATE('07-08-2018', 'dd-mm-yyyy'),20, 30, 22, 2, 3, 7, 15, 1, 25);


SELECT * FROM custos_servicos;

-- ## Insert to Resumos Viagens ##
INSERT INTO resumos_Veiculos(instante, data_inicio, data_fim, matricula, nr_viagens, soma_km, soma_duracao)
VALUES(TO_TIMESTAMP('22/10/2019 06:24', 'dd/mm/yyyy hh24:mi'),TO_DATE('29-04-2019', 'dd-mm-yyyy'),TO_DATE('05-05-2019', 'dd-mm-yyyy'),'82-LT-13', 3, 177, 197);

INSERT INTO resumos_Veiculos(instante, data_inicio, data_fim, matricula, nr_viagens, soma_km, soma_duracao)
VALUES(TO_TIMESTAMP('22/10/2019 06:24', 'dd/mm/yyyy hh24:mi'),TO_DATE('29-04-2019', 'dd-mm-yyyy'),TO_DATE('05-05-2019', 'dd-mm-yyyy'),'82-LT-13', 2, 115, 102);

INSERT INTO resumos_Veiculos(instante, data_inicio, data_fim, matricula, nr_viagens, soma_km, soma_duracao)
VALUES(TO_TIMESTAMP('22/10/2019 06:24', 'dd/mm/yyyy hh24:mi'),TO_DATE('29-04-2019', 'dd-mm-yyyy'),TO_DATE('05-05-2019', 'dd-mm-yyyy'),'82-LT-13', 3, 137, 129);

INSERT INTO resumos_Veiculos(instante, data_inicio, data_fim, matricula, nr_viagens, soma_km, soma_duracao, taxa_IVA, tempo_maximo_espera_minutos, custo_espera_minutos, custo_cancelamento_pedido)
VALUES(TO_TIMESTAMP('22/10/2019 06:24', 'dd/mm/yyyy hh24:mi'),TO_DATE('29-04-2019', 'dd-mm-yyyy'),TO_DATE('05-05-2019', 'dd-mm-yyyy'),'82-LT-13', 1, 26, 51);


SELECT * FROM custos_servicos;
