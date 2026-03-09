-- =====================================================
-- 10 - ORGANIZATION - Tabela de Tokens de Confirmação
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `TokenConfirmaAcao` (
  `IdToken` CHAR(36) NOT NULL,
  CONSTRAINT `PK_TokenConfirmaAcao` PRIMARY KEY (`IdToken`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `TokenConfirmaAcao` ADD COLUMN `IdWorkspace` CHAR(36) NOT NULL;
ALTER TABLE `TokenConfirmaAcao` ADD COLUMN `IdUsuario` CHAR(36) NOT NULL;
ALTER TABLE `TokenConfirmaAcao` ADD COLUMN `TipoAcao` INT NOT NULL;
ALTER TABLE `TokenConfirmaAcao` ADD COLUMN `Token` VARCHAR(100) NOT NULL;
ALTER TABLE `TokenConfirmaAcao` ADD COLUMN `DadosAcao` TEXT NOT NULL;
ALTER TABLE `TokenConfirmaAcao` ADD COLUMN `DataCriacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `TokenConfirmaAcao` ADD COLUMN `DataExpiracao` DATETIME NOT NULL;
ALTER TABLE `TokenConfirmaAcao` ADD COLUMN `IsUsado` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `TokenConfirmaAcao` ADD COLUMN `UsadoEm` DATETIME NULL;

-- Comentários
ALTER TABLE `TokenConfirmaAcao` COMMENT = 'Tabela de tokens para confirmação de ações sensíveis em workspaces';
ALTER TABLE `TokenConfirmaAcao` MODIFY COLUMN `IdToken` CHAR(36) NOT NULL COMMENT 'Identificador único do token';
ALTER TABLE `TokenConfirmaAcao` MODIFY COLUMN `IdWorkspace` CHAR(36) NOT NULL COMMENT 'FK para Workspace relacionado';
ALTER TABLE `TokenConfirmaAcao` MODIFY COLUMN `IdUsuario` CHAR(36) NOT NULL COMMENT 'FK para Usuario que iniciou a ação';
ALTER TABLE `TokenConfirmaAcao` MODIFY COLUMN `TipoAcao` INT NOT NULL COMMENT 'Tipo de ação: 1=ExclusaoMatrizComFiliais, 2=TransferirFilialParaMatriz, 3=TransferirMatrizParaFilial, 4=DesvincularFiliais';
ALTER TABLE `TokenConfirmaAcao` MODIFY COLUMN `Token` VARCHAR(100) NOT NULL COMMENT 'Token de confirmação gerado (código alfanumérico)';
ALTER TABLE `TokenConfirmaAcao` MODIFY COLUMN `DadosAcao` TEXT NOT NULL COMMENT 'Dados da ação em formato JSON';
ALTER TABLE `TokenConfirmaAcao` MODIFY COLUMN `DataCriacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de criação do token';
ALTER TABLE `TokenConfirmaAcao` MODIFY COLUMN `DataExpiracao` DATETIME NOT NULL COMMENT 'Data de expiração do token';
ALTER TABLE `TokenConfirmaAcao` MODIFY COLUMN `IsUsado` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se o token já foi usado';
ALTER TABLE `TokenConfirmaAcao` MODIFY COLUMN `UsadoEm` DATETIME NULL COMMENT 'Data em que o token foi usado';

-- Constraints e Índices
ALTER TABLE `TokenConfirmaAcao` ADD CONSTRAINT `UK_TokenConfirmaAcao_Token` UNIQUE (`Token`);
ALTER TABLE `TokenConfirmaAcao` ADD CONSTRAINT `FK_TokenConfirmaAcao_Workspace` FOREIGN KEY (`IdWorkspace`) REFERENCES `Workspace` (`IdWorkspace`) ON DELETE CASCADE;
ALTER TABLE `TokenConfirmaAcao` ADD INDEX `IX_TokenConfirmaAcao_IdWorkspace` (`IdWorkspace`);
ALTER TABLE `TokenConfirmaAcao` ADD INDEX `IX_TokenConfirmaAcao_IdUsuario` (`IdUsuario`);
ALTER TABLE `TokenConfirmaAcao` ADD INDEX `IX_TokenConfirmaAcao_TipoAcao` (`TipoAcao`);
ALTER TABLE `TokenConfirmaAcao` ADD INDEX `IX_TokenConfirmaAcao_IsUsado` (`IsUsado`);
ALTER TABLE `TokenConfirmaAcao` ADD INDEX `IX_TokenConfirmaAcao_DataExpiracao` (`DataExpiracao`);
ALTER TABLE `TokenConfirmaAcao` ADD INDEX `IX_TokenConfirmaAcao_Token` (`Token`);

