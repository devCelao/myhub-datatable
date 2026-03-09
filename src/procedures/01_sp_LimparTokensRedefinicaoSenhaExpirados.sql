-- =====================================================
-- Stored Procedure: sp_LimparTokensRedefinicaoSenhaExpirados
-- Descrição: Remove códigos de redefinição de senha expirados há mais de 7 dias
-- =====================================================

DELIMITER $$

CREATE PROCEDURE IF NOT EXISTS `sp_LimparTokensRedefinicaoSenhaExpirados`()
BEGIN
    DECLARE v_data_limite DATETIME(6);
    DECLARE v_tokens_removidos INT;
    
    -- Tokens expirados há mais de 7 dias
    SET v_data_limite = DATE_SUB(UTC_TIMESTAMP(), INTERVAL 7 DAY);
    
    -- Deletar tokens expirados e já utilizados ou inativos
    DELETE FROM `TokenRedefinicaoSenha`
    WHERE `DataExpiracao` < v_data_limite
      AND (`IndUtilizado` = 1 OR `IndAtivo` = 0);
    
    SET v_tokens_removidos = ROW_COUNT();
    
    SELECT 
        v_tokens_removidos AS TokensRemovidos,
        UTC_TIMESTAMP() AS DataExecucao;
END$$

DELIMITER ;


