-- =====================================================
-- 11 - IDENTITY - Tabela de Tokens de Ativação de Conta
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `TokenAtivacaoConta` (
  `IdToken` CHAR(36) NOT NULL,
  CONSTRAINT `PK_TokenAtivacaoConta` PRIMARY KEY (`IdToken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `TokenAtivacaoConta` ADD COLUMN `IdUsuario` CHAR(36) NOT NULL;
ALTER TABLE `TokenAtivacaoConta` ADD COLUMN `Token` VARCHAR(500) NOT NULL;
ALTER TABLE `TokenAtivacaoConta` ADD COLUMN `DataCriacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `TokenAtivacaoConta` ADD COLUMN `DataExpiracao` DATETIME NOT NULL;
ALTER TABLE `TokenAtivacaoConta` ADD COLUMN `IsUsado` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `TokenAtivacaoConta` ADD COLUMN `UsadoEm` DATETIME NULL;
ALTER TABLE `TokenAtivacaoConta` ADD COLUMN `TentativasValidacao` INT NOT NULL DEFAULT 0;
ALTER TABLE `TokenAtivacaoConta` ADD COLUMN `IpOrigem` VARCHAR(45) NULL;

-- Comentários
ALTER TABLE `TokenAtivacaoConta` COMMENT = 'Tabela de tokens para ativação de conta de usuários';
ALTER TABLE `TokenAtivacaoConta` MODIFY COLUMN `IdToken` CHAR(36) NOT NULL COMMENT 'Identificador único do token';
ALTER TABLE `TokenAtivacaoConta` MODIFY COLUMN `IdUsuario` CHAR(36) NOT NULL COMMENT 'FK para Usuario';
ALTER TABLE `TokenAtivacaoConta` MODIFY COLUMN `Token` VARCHAR(500) NOT NULL COMMENT 'Token único de ativação (Base64 URL-safe)';
ALTER TABLE `TokenAtivacaoConta` MODIFY COLUMN `DataCriacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de criação do token';
ALTER TABLE `TokenAtivacaoConta` MODIFY COLUMN `DataExpiracao` DATETIME NOT NULL COMMENT 'Data de expiração do token (72h)';
ALTER TABLE `TokenAtivacaoConta` MODIFY COLUMN `IsUsado` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se o token foi usado';
ALTER TABLE `TokenAtivacaoConta` MODIFY COLUMN `UsadoEm` DATETIME NULL COMMENT 'Data de uso do token';
ALTER TABLE `TokenAtivacaoConta` MODIFY COLUMN `TentativasValidacao` INT NOT NULL DEFAULT 0 COMMENT 'Contador de tentativas de validação (max 5)';
ALTER TABLE `TokenAtivacaoConta` MODIFY COLUMN `IpOrigem` VARCHAR(45) NULL COMMENT 'IP de origem da ativação (IPv4 ou IPv6)';

-- Constraints e Índices
ALTER TABLE `TokenAtivacaoConta` ADD CONSTRAINT `FK_TokenAtivacaoConta_Usuario` FOREIGN KEY (`IdUsuario`) REFERENCES `Usuario` (`IdUsuario`) ON DELETE CASCADE;
ALTER TABLE `TokenAtivacaoConta` ADD CONSTRAINT `UK_TokenAtivacaoConta_Token` UNIQUE (`Token`);
ALTER TABLE `TokenAtivacaoConta` ADD INDEX `IX_TokenAtivacaoConta_IdUsuario` (`IdUsuario`);
ALTER TABLE `TokenAtivacaoConta` ADD INDEX `IX_TokenAtivacaoConta_Token` (`Token`);
ALTER TABLE `TokenAtivacaoConta` ADD INDEX `IX_TokenAtivacaoConta_DataExpiracao` (`DataExpiracao`);
ALTER TABLE `TokenAtivacaoConta` ADD INDEX `IX_TokenAtivacaoConta_IsUsado` (`IsUsado`);

