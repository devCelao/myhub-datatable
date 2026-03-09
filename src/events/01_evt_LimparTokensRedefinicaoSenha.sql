-- =====================================================
-- Event: evt_LimparTokensRedefinicaoSenha
-- Descrição: Limpa tokens de redefinição de senha expirados automaticamente (diariamente às 3h)
-- =====================================================

-- Habilitar event scheduler (se não estiver habilitado)
-- SET GLOBAL event_scheduler = ON;

CREATE EVENT IF NOT EXISTS `evt_LimparTokensRedefinicaoSenha`
ON SCHEDULE EVERY 1 DAY
STARTS (TIMESTAMP(CURRENT_DATE) + INTERVAL 1 DAY + INTERVAL 3 HOUR)
DO
    CALL `sp_LimparTokensRedefinicaoSenhaExpirados`();


