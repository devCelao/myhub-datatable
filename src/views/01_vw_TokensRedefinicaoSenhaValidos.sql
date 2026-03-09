-- =====================================================
-- View: vw_TokensRedefinicaoSenhaValidos
-- Descrição: Facilita consulta de códigos válidos para redefinição de senha
-- =====================================================

CREATE OR REPLACE VIEW `vw_TokensRedefinicaoSenhaValidos` AS
SELECT 
    t.`Id`,
    t.`IdUsuario`,
    t.`Email`,
    t.`DataCriacao`,
    t.`DataExpiracao`,
    t.`TentativasInvalidas`,
    t.`IpSolicitacao`,
    TIMESTAMPDIFF(MINUTE, UTC_TIMESTAMP(), t.`DataExpiracao`) AS MinutosRestantes,
    u.`IndAtivo` AS UsuarioAtivo
FROM `TokenRedefinicaoSenha` t
INNER JOIN `AcessoUsuario` u ON t.`IdUsuario` = u.`IdUsuario`
WHERE t.`IndAtivo` = 1
  AND t.`IndUtilizado` = 0
  AND t.`DataExpiracao` > UTC_TIMESTAMP()
  AND t.`TentativasInvalidas` < 5;


