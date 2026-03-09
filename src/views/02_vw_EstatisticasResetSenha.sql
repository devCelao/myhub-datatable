-- =====================================================
-- View: vw_EstatisticasResetSenha
-- Descrição: Métricas para monitoramento de reset de senha
-- =====================================================

CREATE OR REPLACE VIEW `vw_EstatisticasResetSenha` AS
SELECT 
    DATE(DataCriacao) AS Data,
    COUNT(*) AS TotalSolicitacoes,
    SUM(CASE WHEN IndUtilizado = 1 THEN 1 ELSE 0 END) AS TokensUtilizados,
    SUM(CASE WHEN IndAtivo = 0 THEN 1 ELSE 0 END) AS TokensInativados,
    SUM(CASE WHEN DataExpiracao < UTC_TIMESTAMP() AND IndUtilizado = 0 THEN 1 ELSE 0 END) AS TokensExpirados,
    SUM(CASE WHEN TentativasInvalidas >= 5 THEN 1 ELSE 0 END) AS TokensBloqueados,
    AVG(TentativasInvalidas) AS MediaTentativasInvalidas
FROM `TokenRedefinicaoSenha`
GROUP BY DATE(DataCriacao)
ORDER BY Data DESC;


