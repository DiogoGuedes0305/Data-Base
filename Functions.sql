--Exercício 1 --
CREATE OR REPLACE FUNCTION funcTopServico(p_cod_servico servicos.cod_servico%type,
                            p_data_inicial TIMESTAMP, p_data_final TIMESTAMP,
                            n int ) return sys_refcursor
is
    cursor_id sys_refcursor;
    cod_servico_invalido EXCEPTION;
    n_invalido EXCEPTION;
    maximo_cod_servico int;
Begin
Select MAX(cod_servico) into maximo_cod_servico
From servicos;

if(p_cod_servico > maximo_cod_servico
    OR p_cod_servico<1)then
    raise cod_servico_invalido;
end if;
if(n <1)then
    raise n_invalido;
end if;
Open cursor_id For
    With CalcularCusto as(
    SELECT CASE WHEN(pv.cancelado = 'N')
                THEN cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
                    + (cs.custo_espera_minutos * v.atraso_passageiros_minutos) + (cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
                     + (cs.custo_espera_minutos * v.atraso_passageiros_minutos)) * cs.taxa_IVA
                ELSE cs.custo_cancelamento_pedido  END 
                AS custo, pv.nr_idCivil, s.cod_servico, pv.cod_pedido, pv.data_hora_pedido
                FROM Custos_Servicos cs, Servicos s, Pedidos_Viagens pv, Viagens v
                WHERE( s.cod_servico = cs.cod_servico AND s.cod_servico = pv.cod_servico AND  pv.cod_pedido = v.cod_pedido)) 
    select nr_idCivil
    From CalcularCusto c1
    Where c1.cod_servico= p_cod_servico 
        and (c1.data_hora_pedido between p_data_inicial and p_data_final)
        and (select count(*) 
            from CalcularCusto c2
            where c2.cod_servico = c1.cod_servico
            and (c2.data_hora_pedido between p_data_inicial and p_data_final)
            and c2.custo >= c1.custo) <= n  ;
Return(cursor_id);
Exception 
    WHEN cod_servico_invalido Then
        return null;
    WHEN n_invalido Then
        return null;   
end;
/

Set SERVEROUTPUT ON;
Declare
    l_valores sys_refcursor;
    l_item Condutores.nr_idCivil%type;
Begin
 
 if funcTopServico(1, TO_TIMESTAMP('17/05/2000 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),2 ) IS null then
        DBMS_OUTPUT.PUT_LINE('DADOS INVALIDOS');
    else
    l_valores:=funcTopServico(1 ,TO_TIMESTAMP('17/05/2000 06:00','dd/mm/yyyy hh24:mi'),TO_TIMESTAMP('17/05/2018 06:00','dd/mm/yyyy hh24:mi'),3);
    Loop
        Fetch l_valores into l_item;
        Exit when l_valores%NOTFOUND;
        dbms_output.put_line (l_item);
    END LOOP;
end if;
END;
/

-- Exercício 2--
CREATE OR REPLACE FUNCTION funcSobreposicoesVeiculosCondutores return boolean
is 
    contador_sobreposicoes int;
    BEGIN
        select count(*) into contador_sobreposicoes
        from Veiculos_Condutores v1
        INNER JOIN(
            select * from Veiculos_Condutores) v2
        ON(( v2.matricula = v1.matricula and v2.nr_idCivil != v1.nr_idCivil) OR ( v2.matricula != v1.matricula and v2.nr_idCivil = v1.nr_idCivil))
        Where( v2.data_inicio >= v1.data_inicio and  v2.data_inicio < v1.data_fim);

        IF (contador_sobreposicoes = 0) THEN
            RETURN false;
        else
            RETURN true;
        end if;
    end;
    
SET SERVEROUTPUT ON
BEGIN
    if (funcSobreposicoesVeiculosCondutores = false) then
        DBMS_OUTPUT.PUT_LINE('Nao existem sobreposicoes temporais');
    else
        DBMS_OUTPUT.PUT_LINE('Existem sobreposicoes temporais');
    end if;
end;

-- Exercício 3 -- 
CREATE OR REPLACE FUNCTION funcObterInfoSemanalVeiculos(p_data Date) RETURN sys_refcursor IS

    c_veiculos sys_refcursor;

BEGIN
    OPEN c_veiculos FOR
        WITH sum_total AS(
        SELECT vc.matricula matricula, vc.data_inicio, vc.data_fim, pv.distancia_km, v.duracao_minutos
        FROM veiculos_condutores vc
        INNER JOIN pedidos_viagens pv on vc.matricula = pv.matricula and vc.matricula = pv.matricula and vc.nr_idcivil = pv.nr_idcivil and vc.data_inicio = pv.data_inicio
        INNER JOIN viagens v on pv.cod_pedido = v.cod_pedido
        WHERE vc.matricula = pv.matricula
        AND (pv.data_hora_recolha_passageiro >= TRUNC(p_data, 'iw' )
        AND pv.data_hora_recolha_passageiro <= TRUNC(p_data, 'iw ')+7-1/86400))
        SELECT matricula, TRUNC(p_data, 'iw') data_inicio, TRUNC(p_data, 'iw' ) +7-1/86400 data_fim, count(*) nrºviagens, sum(distancia_km), sum(duracao_minutos)
        FROM sum_total
        GROUP BY matricula;

        RETURN c_veiculos;

END;
/


--Exercício 4--
CREATE OR REPLACE FUNCTION valorMaisVol
    RETURN Servicos.cod_servico%TYPE
AS
    cod_serv servicos.cod_servico%TYPE;

BEGIN
with CalcularCusto as(
         SELECT CASE WHEN(pv.cancelado = 'N') THEN cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
         + (cs.custo_espera_minutos * v.atraso_passageiros_minutos) + (cs.preco_base + (cs.custo_minuto * v.duracao_minutos) + (cs.custo_km * pv.distancia_km)
         + (cs.custo_espera_minutos * v.atraso_passageiros_minutos)) * cs.taxa_IVA ELSE cs.custo_cancelamento_pedido END AS custo, pv.nr_idCivil, s.cod_servico, pv.cod_pedido, pv.data_hora_pedido FROM Custos_Servicos cs, 
         Servicos s, Pedidos_Viagens pv, Viagens v
         WHERE( s.cod_servico = cs.cod_servico AND s.cod_servico = pv.cod_servico AND  pv.cod_pedido = v.cod_pedido) and pv.data_hora_pedido between  add_months( trunc(sysdate), -12) and sysdate)
SELECT sT.cod_servico into cod_serv
FROM  (Select cc1.cod_servico, sum(cc1.custo) as soma
        From CalcularCusto cc1
        group by cc1.cod_servico) sT
where  sT.soma = (Select MAX(y.nume)
                               FROM (SELECT SUM(cc2.custo) as nume
                               From CalcularCusto cc2 
                               Group by cod_servico) y);



RETURN cod_serv;
END;
/

CREATE OR REPLACE PROCEDURE procAtualizarCustosServico(x NUMERIC, data_atualizar DATE DEFAULT sysdate)
AS
    n servicos.cod_servico%TYPE;
    data_ultima DATE;
    ex_ultima_atualizacao_tempo_insuficiente EXCEPTION;
    checker int;
BEGIN

    n := valorMaisVol;
    SELECT data_ultima_atualizacao
    INTO
        data_Ultima
    FROM custos_servicos
    WHERE (custos_servicos.cod_servico = n);
    IF (add_months(TRUNC(data_ultima), 6) > data_atualizar)
    THEN
        RAISE ex_ultima_atualizacao_tempo_insuficiente;
    END IF;
    UPDATE custos_servicos
    SET custos_servicos.preco_base= custos_servicos.preco_base * (1 + (x * 0.01)),
        custos_servicos.custo_minuto = custos_servicos.custo_minuto * (1 + (x * 0.01)),
        custos_servicos.custo_espera_minutos = custos_servicos.custo_espera_minutos * (1 + (x * 0.01)),
        custos_servicos.custo_cancelamento_pedido = custos_servicos.custo_cancelamento_pedido * (1 + (x * 0.01)),
        custos_servicos.data_ultima_atualizacao = data_Atualizar
    WHERE cod_servico = n;

EXCEPTION
    WHEN ex_ultima_atualizacao_tempo_insuficiente
        THEN
            raise_application_error(-20001, 'A última atualização não tem 6 meses ainda.');
END;
/
set SERVEROUTPUT ON
EXEC procAtualizarCustosServico(500);

Select * 
From custos_servicos;


--Exercicio 6--
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE PROCGUARDARINFORMACAOSEMANAL (p_date in DATE) AS 

l_cursor SYS_REFCURSOR;
l_auxiliar resumosveiculos%rowtype;
l_veiculosNaoNulos INTEGER;
l_veiculosTotal INTEGER;
l_percentagem FLOAT;

l_resumo resumosveiculos%rowtype;
l_matricula resumosveiculos.matricula%type;

l_sim CHAR(3) := 'SIM';
l_nao CHAR(3) := 'NAO';

Cursor fezViagem is 
        select rv1.matricula as Matricula
        from resumosveiculos rv1
        where rv1.nr_viagens is not null;

Cursor naoFezViagem is        
        select rv2.matricula as Matricula
        from resumosveiculos rv2
        where rv2.nr_viagens is null;

BEGIN 

    l_cursor := FUNCOBTERINFOSEMANALVEICULOS(p_date);
    LOOP 
        FETCH l_cursor into l_auxiliar;
        EXIT WHEN l_cursor%NOTFOUND;
        INSERT INTO resumosveiculos VALUES(CURRENT_TIMESTAMP,l_auxiliar.data_inicio,l_auxiliar.data_fim,l_auxiliar.matricula,l_auxiliar.nr_viagens,l_auxiliar.soma_km,l_auxiliar.soma_duracao);
    END LOOP;
    
    select count(*) into l_veiculosNaoNulos 
    from resumosveiculos rv
    where rv.nr_viagens is not null;
    
    select count(*) into l_veiculosTotal
    from resumosveiculos;

    l_percentagem := l_veiculosNaoNulos/l_veiculosTotal * 100; 
    
    --DBMS_OUTPUT.PUT_LINE('Percentagem : ' || l_percentagem);
    
    OPEN fezViagem;
        LOOP 
        FETCH fezViagem into l_matricula;
        EXIT WHEN fezViagem%notfound;
            DBMS_OUTPUT.PUT_LINE(RPAD(l_sim,5,' ') || RPAD(l_percentagem,5,' ') || l_matricula);
        END LOOP;
    CLOSE fezViagem;
    
    OPEN naoFezViagem;
        LOOP 
        FETCH naoFezViagem into l_matricula;
        EXIT WHEN naoFezViagem%notfound;
            DBMS_OUTPUT.PUT_LINE(RPAD(l_nao,5,' ') || RPAD(100 - l_percentagem,5,' ') || l_matricula);
        END LOOP;
    CLOSE naoFezViagem;

END PROCGUARDARINFORMACAOSEMANAL;
/
