-- =====================================================
-- 13 - AUTHENTICATION - Tabela de Refresh Tokens (JWKS)
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `RefreshToken` (
  `IdRefreshToken` CHAR(36) NOT NULL,
  CONSTRAINT `PK_RefreshToken` PRIMARY KEY (`IdRefreshToken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `RefreshToken` ADD COLUMN `IdUsuario` CHAR(36) NOT NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `Token` VARCHAR(500) NOT NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `TokenHash` VARCHAR(100) NOT NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `JwtId` VARCHAR(100) NOT NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `DataCriacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `RefreshToken` ADD COLUMN `DataExpiracao` DATETIME NOT NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `IndRevogado` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `RefreshToken` ADD COLUMN `DataRevogacao` DATETIME NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `MotivoRevogacao` VARCHAR(500) NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `IdRefreshTokenSubstituido` CHAR(36) NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `IndUtilizado` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `RefreshToken` ADD COLUMN `DataUtilizacao` DATETIME NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `DeviceInfo` VARCHAR(1000) NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `IpOrigem` VARCHAR(45) NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `UserAgent` VARCHAR(500) NULL;
ALTER TABLE `RefreshToken` ADD COLUMN `VersaoSenhaUsuario` INT NOT NULL;

-- Comentários
ALTER TABLE `RefreshToken` COMMENT = 'Tabela de refresh tokens JWT com suporte a rotação e JWKS';
ALTER TABLE `RefreshToken` MODIFY COLUMN `IdRefreshToken` CHAR(36) NOT NULL COMMENT 'Identificador único do refresh token';
ALTER TABLE `RefreshToken` MODIFY COLUMN `IdUsuario` CHAR(36) NOT NULL COMMENT 'FK para AcessoUsuario';
ALTER TABLE `RefreshToken` MODIFY COLUMN `Token` VARCHAR(500) NOT NULL COMMENT 'Token JWT criptografado';
ALTER TABLE `RefreshToken` MODIFY COLUMN `TokenHash` VARCHAR(100) NOT NULL COMMENT 'Hash SHA256 do token para validação';
ALTER TABLE `RefreshToken` MODIFY COLUMN `JwtId` VARCHAR(100) NOT NULL COMMENT 'Identificador único do JWT (jti claim)';
ALTER TABLE `RefreshToken` MODIFY COLUMN `DataCriacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de criação do token';
ALTER TABLE `RefreshToken` MODIFY COLUMN `DataExpiracao` DATETIME NOT NULL COMMENT 'Data de expiração do token (30 dias)';
ALTER TABLE `RefreshToken` MODIFY COLUMN `IndRevogado` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se o token foi revogado';
ALTER TABLE `RefreshToken` MODIFY COLUMN `DataRevogacao` DATETIME NULL COMMENT 'Data de revogação do token';
ALTER TABLE `RefreshToken` MODIFY COLUMN `MotivoRevogacao` VARCHAR(500) NULL COMMENT 'Motivo da revogação';
ALTER TABLE `RefreshToken` MODIFY COLUMN `IdRefreshTokenSubstituido` CHAR(36) NULL COMMENT 'ID do token que substituiu este (chain de rotação)';
ALTER TABLE `RefreshToken` MODIFY COLUMN `IndUtilizado` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se o token já foi utilizado (detectar reuso)';
ALTER TABLE `RefreshToken` MODIFY COLUMN `DataUtilizacao` DATETIME NULL COMMENT 'Data em que o token foi utilizado';
ALTER TABLE `RefreshToken` MODIFY COLUMN `DeviceInfo` VARCHAR(1000) NULL COMMENT 'Informações do dispositivo (JSON)';
ALTER TABLE `RefreshToken` MODIFY COLUMN `IpOrigem` VARCHAR(45) NULL COMMENT 'IP de origem da criação (IPv4 ou IPv6)';
ALTER TABLE `RefreshToken` MODIFY COLUMN `UserAgent` VARCHAR(500) NULL COMMENT 'User Agent do browser/app';
ALTER TABLE `RefreshToken` MODIFY COLUMN `VersaoSenhaUsuario` INT NOT NULL COMMENT 'Versão da senha do usuário (invalida se senha mudou)';

-- Constraints e Índices
ALTER TABLE `RefreshToken` ADD CONSTRAINT `UK_RefreshToken_TokenHash` UNIQUE (`TokenHash`);
ALTER TABLE `RefreshToken` ADD CONSTRAINT `FK_RefreshToken_AcessoUsuario` FOREIGN KEY (`IdUsuario`) REFERENCES `AcessoUsuario` (`IdUsuario`) ON DELETE CASCADE;
ALTER TABLE `RefreshToken` ADD CONSTRAINT `FK_RefreshToken_TokenSubstituido` FOREIGN KEY (`IdRefreshTokenSubstituido`) REFERENCES `RefreshToken` (`IdRefreshToken`) ON DELETE RESTRICT;
ALTER TABLE `RefreshToken` ADD INDEX `IX_RefreshToken_IdUsuario` (`IdUsuario`);
ALTER TABLE `RefreshToken` ADD INDEX `IX_RefreshToken_JwtId` (`JwtId`);
ALTER TABLE `RefreshToken` ADD INDEX `IX_RefreshToken_DataExpiracao` (`DataExpiracao`);
ALTER TABLE `RefreshToken` ADD INDEX `IX_RefreshToken_IndRevogado` (`IndRevogado`);
ALTER TABLE `RefreshToken` ADD INDEX `IX_RefreshToken_IndUtilizado` (`IndUtilizado`);
ALTER TABLE `RefreshToken` ADD INDEX `IX_RefreshToken_TokenHash` (`TokenHash`);

