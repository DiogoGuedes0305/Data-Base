----------------Trigger 1------------------------
-- Devido ao SQL verificar as constraints ANTES do BEFORE nao conseguimos alterar os valores da matricula, nr_id_civil e data_inicio por causa da 
-- restricao Foreign Key entao nos decidimos comentar essa constraint pois este triger fa-lo automaticamente
/*create or replace TRIGGER trgAtribuicaoPedido
BEFORE INSERT ON Pedidos_Viagens
FOR EACH ROW
DECLARE
ex_nenhum_veiculo_condutor_disponivel EXCEPTION;
l_condutor   Condutores.nr_idCivil%TYPE;
l_matricula  Veiculos.matricula%type;
l_veiculos_disponiveis INTEGER;

CURSOR c_veiculos IS
    SELECT v.matricula 
    FROM Veiculos v 
    WHERE v.kms_semanais - :NEW.distancia_km >= 0;

BEGIN
    OPEN c_veiculos;
    LOOP 
        FETCH c_veiculos INTO l_matricula;
        
        SELECT COUNT(*) INTO l_veiculos_disponiveis 
        FROM Veiculos v 
        WHERE v.matricula NOT IN (select cv.matricula 
                                  from Veiculos_Condutores cv
                                  where CURRENT_TIMESTAMP between cv.data_inicio and cv.data_fim);
        
        IF l_veiculos_disponiveis != 0 THEN
            SELECT c.nr_idCivil INTO l_condutor 
            FROM Condutores c 
            WHERE c.nr_idCivil NOT IN (select cv.nr_idCivil 
                                                 from Veiculos_Condutores cv
                                                 where CURRENT_TIMESTAMP between cv.data_inicio and cv.data_fim)
            FETCH FIRST 1 ROW ONLY;
        END IF;
        
    EXIT WHEN l_condutor IS NOT NULL AND l_veiculos_disponiveis > 0;

    IF l_veiculos_disponiveis = 0 THEN
        RAISE ex_nenhum_veiculo_condutor_disponivel;
    END IF;
    END LOOP;
    
    UPDATE Veiculos v SET kms_semanais = kms_semanais - :NEW.distancia_km;
    
    INSERT INTO Veiculos_Condutores VALUES(l_matricula,l_condutor, CURRENT_TIMESTAMP, (CURRENT_TIMESTAMP + :NEW.estimativa_duracao/24/60));

    :NEW.matricula := l_matricula;
    :NEW.nr_idCivil_Condutor := l_condutor;
    :NEW.data_inicio :=  CURRENT_TIMESTAMP;

    EXCEPTION
    WHEN ex_nenhum_veiculo_condutor_disponivel THEN
        raise_application_error(-20111,'Não foram encontrados Veiculos');
END;
*/

----------------Test for Trigger 1------------------------

INSERT INTO Modelo_Veiculo(modelo ,marca)
VALUES ('yaris', 'Toyota');

INSERT INTO Chassis(nr_chassis, modelo)
VALUES ('1234', 'yaris');

INSERT INTO Veiculos(matricula, data_matricula, kms_percorridos, kms_semanais)
VALUES ('45-XX-98', TO_DATE('1999/06/24', 'YYYY/MM/DD'), 185, 300);

INSERT INTO Veiculo_Chassis(matricula, nr_chassis)
VALUES ('45-XX-98', '1234');

INSERT INTO carta_conducao(nr_cartaConducao, data_validade_cartaConducao)
VALUES (1122,  TO_DATE('03-11-2010', 'dd-mm-yyyy'));

INSERT INTO condutores(nr_idCivil, nr_idCivil_supervisor, nr_cartaConducao, nome, data_nascimento, nr_contribuinte, morada)
VALUES(11111111, null, 1122, 'Pedro Carneiro', TO_DATE('16-04-1984', 'dd-mm-yyyy'), 11111, 'Rua Feliz');

--Não é necessário inserir nada nesta tabela pois o Trigger associa a tabela veículos com a tabela condutores
--INSERT INTO Veiculos_Condutores(matricula, nr_idCivil, data_inicio, data_fim) VALUES ('45-XX-98',11111111, TO_DATE('26-04-2008', 'dd-mm-yyyy'),TO_DATE('27-04-2008', 'dd-mm-yyyy'));

INSERT INTO Cliente(nr_idCivil, nr_contribuinte, data_nascimento, nome, morada)
VALUES (101010, 010101, TO_DATE('10-07-1976', 'dd-mm-yyyy'), 'Pedro J.', 'Rua Triste');

INSERT INTO Login(login, passwordCliente)
VALUES ('pedro85', 'banana');

INSERT INTO Login_Cliente(login, nr_idCivil_Cliente)
VALUES ('pedro85', 101010);

INSERT INTO Tipo_Servico(cod_tipo_servico, descricao, custo_cancelamento, percentagem_comissao_supervisor)
VALUES (1, 'Luxo', 10, 0.3);

INSERT INTO Servico(cod_servico, cod_tipo_servico)
VALUES (1, 1);

--Verificar que a tabela não têm nada
select * from Veiculos_Condutores;

--Testar para Verdadeiro
INSERT INTO Pedidos_Viagens(cod_pedido, cod_servico, login_Cliente, data_hora_pedido, data_hora_recolha_passageiro, distancia_km, estimativa_duracao)
VALUES(12, 1, 'pedro85' , TO_TIMESTAMP('25/03/2008 16:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('25/03/2008 22:35', 'dd/mm/yyyy hh24:mi'),30, 20);

select * from Pedidos_Viagens;

--Testar para Falso
INSERT INTO Pedidos_Viagens(cod_pedido, matricula, nr_idCivil_Condutor, data_inicio, cod_servico, login_Cliente, data_hora_pedido, data_hora_recolha_passageiro, distancia_km)
VALUES(13,  1, 'pedro85' , TO_TIMESTAMP('25/03/2008 16:35',  'dd/mm/yyyy hh24:mi'), TO_TIMESTAMP('25/03/2008 22:35', 'dd/mm/yyyy hh24:mi'),30, 20);


----------------Trigger 4------------------------

CREATE OR REPLACE TRIGGER trgCondutoresVeiculosAssociacoes
    BEFORE INSERT ON Veiculos_Condutores
    FOR EACH ROW
    DECLARE
        cp_matricula Veiculos_Condutores.matricula%type;
        cp_nr_idcivil Veiculos_Condutores.nr_idCivil%type;
        cp_data_inicio Veiculos_Condutores.data_inicio%type;
        cp_data_fim Veiculos_Condutores.data_fim%type;
        existem_sobreposicoes EXCEPTION;

        cursor cur_veiculos_condutores is select *
        from Veiculos_Condutores v1;
    begin
        open cur_veiculos_condutores;
            loop
                exit when cur_veiculos_condutores%notfound;
                fetch cur_veiculos_condutores into cp_matricula, cp_nr_idcivil, cp_data_inicio, cp_data_fim;
                if ((( cp_matricula = :new.matricula and cp_nr_idcivil != :new.nr_idCivil) OR ( cp_matricula != :new.matricula and cp_nr_idcivil = :new.nr_idCivil)) 
                and  :new.data_inicio >= cp_data_inicio and :new.data_inicio < cp_data_fim) THEN
                    raise existem_sobreposicoes;
                end if;
                if ((( cp_matricula = :new.matricula and cp_nr_idcivil != :new.nr_idCivil) OR ( cp_matricula != :new.matricula and cp_nr_idcivil = :new.nr_idCivil)) 
                and  :new.data_inicio <= cp_data_inicio and :new.data_fim > cp_data_inicio) THEN
                    raise existem_sobreposicoes;
                end if;
            end loop;
    EXCEPTION
        WHEN existem_sobreposicoes THEN
            raise_application_error(-20001, 'Nao foi possivel efetuar registo/update devido a sobreposicoes.');
    end;
    
    
    ----------------Test for Trigger 4------------------------
    
    delete Itinerarios_Viagens;
    delete Viagens;
    delete Pedidos_Viagens;
    delete Veiculos_Condutores;

    INSERT INTO Modelo_Veiculo(modelo ,marca)
    VALUES ('yaris', 'Toyota');
    
    INSERT INTO Modelo_Veiculo(modelo,marca)
    VALUES('Camry','Toyota');
    
    INSERT INTO Modelo_Veiculo(modelo,marca)
    VALUES('AMG GT','Mercedes');

    INSERT INTO Chassis(nr_chassis,modelo)
    VALUES(2000,'yaris');
    
    INSERT INTO Chassis(nr_chassis,modelo)
    VALUES(2001,'Camry');
    
    INSERT INTO Chassis(nr_chassis,modelo)
    VALUES(2002,'AMG GT');
    
    INSERT INTO Veiculos(matricula, data_matricula, kms_percorridos, kms_semanais) 
    VALUES('45-XX-98', TO_DATE('08-12', 'mm-yy'),0, 500);

    INSERT INTO Veiculos(matricula, data_matricula, kms_percorridos, kms_semanais) 
    VALUES('15-WW-12', TO_DATE('08-12', 'mm-yy'),0, 550);
    
    INSERT INTO Veiculos(matricula, data_matricula, kms_percorridos, kms_semanais) 
    VALUES('56-ZD-18', TO_DATE('08-99', 'mm-yy'),0, 600);
    
    INSERT INTO carta_conducao(nr_cartaConducao, data_validade_cartaConducao)
    VALUES (21212121, TO_DATE('23-04-2025', 'dd-mm-yyyy'));
    
    INSERT INTO carta_conducao (nr_cartaConducao, data_validade_cartaConducao)
    VALUES (23232323, TO_DATE('23-04-2026', 'dd-mm-yyyy'));

    INSERT INTO Condutores(nr_idCivil, nr_idCivil_supervisor, nr_cartaConducao, nome, data_nascimento, nr_contribuinte, morada) 
    VALUES(15259466, NULL,21212121, 'Oracio Carneiro', TO_DATE('26-05-1999', 'dd-mm-yyyy'),123456789,'Porto');

    INSERT INTO Condutores(nr_idCivil, nr_idCivil_supervisor, nr_cartaConducao, nome, data_nascimento, nr_contribuinte, morada) 
    VALUES(19999999, NULL,23232323, 'Esteves Malandreco',TO_DATE('18-02-1987', 'dd-mm-yyyy'), 123456780,'Lisboa');

    INSERT INTO Veiculos_Condutores(matricula, nr_idCivil, data_inicio, data_fim)
    VALUES('15-WW-12', 15259466, TO_DATE('12-01-2019', 'dd-mm-yyyy'),TO_DATE('18-01-2019', 'dd-mm-yyyy'));
    --sobreposicao com o primeiro
    INSERT INTO Veiculos_Condutores(matricula, nr_idCivil, data_inicio, data_fim)
    VALUES('45-XX-98', 15259466, TO_DATE('11-01-2019', 'dd-mm-yyyy'),TO_DATE( '15-01-2019' , 'dd-mm-yyyy'));
    --sobreposicao com o primeiro
    INSERT INTO Veiculos_Condutores(matricula, nr_idCivil, data_inicio, data_fim)
    VALUES('45-XX-98', 15259466, TO_DATE('11-01-2019', 'dd-mm-yyyy'),TO_DATE( '19-01-2019' , 'dd-mm-yyyy'));
        
    INSERT INTO Veiculos_Condutores(matricula, nr_idCivil, data_inicio, data_fim)
    VALUES('56-ZD-18', 15259466, TO_DATE('09-01-2019', 'dd-mm-yyyy'),TO_DATE( '11-01-2019' , 'dd-mm-yyyy'));
    --sobreposicao com o anterior
    INSERT INTO Veiculos_Condutores(matricula, nr_idCivil, data_inicio, data_fim)
    VALUES('56-ZD-18', 19999999, TO_DATE('10-01-2019', 'dd-mm-yyyy'),TO_DATE( '20-01-2019' , 'dd-mm-yyyy'));
