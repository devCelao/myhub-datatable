-- =====================================================
-- 08 - INVITE - Tabela de Convites
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `ConviteUsuarioWorkspace` (
  `IdConvite` CHAR(36) NOT NULL,
  CONSTRAINT `PK_ConviteUsuarioWorkspace` PRIMARY KEY (`IdConvite`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `ConviteUsuarioWorkspace` ADD COLUMN `IdWorkspace` CHAR(36) NOT NULL;
ALTER TABLE `ConviteUsuarioWorkspace` ADD COLUMN `IdPerfil` CHAR(36) NOT NULL;
ALTER TABLE `ConviteUsuarioWorkspace` ADD COLUMN `Email` VARCHAR(256) NOT NULL;
ALTER TABLE `ConviteUsuarioWorkspace` ADD COLUMN `Token` VARCHAR(64) NOT NULL;
ALTER TABLE `ConviteUsuarioWorkspace` ADD COLUMN `StatusConvite` INT NOT NULL DEFAULT 0;
ALTER TABLE `ConviteUsuarioWorkspace` ADD COLUMN `TokenCreatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `ConviteUsuarioWorkspace` ADD COLUMN `TokenExpiresAt` DATETIME NOT NULL;
ALTER TABLE `ConviteUsuarioWorkspace` ADD COLUMN `IsUsed` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `ConviteUsuarioWorkspace` ADD COLUMN `UsedAt` DATETIME NULL;

-- Comentários
ALTER TABLE `ConviteUsuarioWorkspace` COMMENT = 'Tabela de convites para usuários entrarem em workspaces';
ALTER TABLE `ConviteUsuarioWorkspace` MODIFY COLUMN `IdConvite` CHAR(36) NOT NULL COMMENT 'Identificador único do convite';
ALTER TABLE `ConviteUsuarioWorkspace` MODIFY COLUMN `IdWorkspace` CHAR(36) NOT NULL COMMENT 'FK para Workspace';
ALTER TABLE `ConviteUsuarioWorkspace` MODIFY COLUMN `IdPerfil` CHAR(36) NOT NULL COMMENT 'FK para Perfil';
ALTER TABLE `ConviteUsuarioWorkspace` MODIFY COLUMN `Email` VARCHAR(256) NOT NULL COMMENT 'Email do usuário convidado';
ALTER TABLE `ConviteUsuarioWorkspace` MODIFY COLUMN `Token` VARCHAR(64) NOT NULL COMMENT 'Token único do convite';
ALTER TABLE `ConviteUsuarioWorkspace` MODIFY COLUMN `StatusConvite` INT NOT NULL DEFAULT 0 COMMENT 'Status: 0=Pendente, 1=Aceito, 2=Revogado, 3=Expirado';
ALTER TABLE `ConviteUsuarioWorkspace` MODIFY COLUMN `TokenCreatedAt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de criação do token';
ALTER TABLE `ConviteUsuarioWorkspace` MODIFY COLUMN `TokenExpiresAt` DATETIME NOT NULL COMMENT 'Data de expiração do token';
ALTER TABLE `ConviteUsuarioWorkspace` MODIFY COLUMN `IsUsed` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se o token foi usado';
ALTER TABLE `ConviteUsuarioWorkspace` MODIFY COLUMN `UsedAt` DATETIME NULL COMMENT 'Data de uso do token';

-- Constraints e Índices
ALTER TABLE `ConviteUsuarioWorkspace` ADD CONSTRAINT `FK_ConviteUsuarioWorkspace_Workspace` FOREIGN KEY (`IdWorkspace`) REFERENCES `Workspace` (`IdWorkspace`) ON DELETE CASCADE;
ALTER TABLE `ConviteUsuarioWorkspace` ADD CONSTRAINT `FK_ConviteUsuarioWorkspace_Perfil` FOREIGN KEY (`IdPerfil`) REFERENCES `Perfil` (`IdPerfil`) ON DELETE RESTRICT;
ALTER TABLE `ConviteUsuarioWorkspace` ADD CONSTRAINT `UK_ConviteUsuarioWorkspace_Token` UNIQUE (`Token`);
ALTER TABLE `ConviteUsuarioWorkspace` ADD INDEX `IX_ConviteUsuarioWorkspace_IdWorkspace` (`IdWorkspace`);
ALTER TABLE `ConviteUsuarioWorkspace` ADD INDEX `IX_ConviteUsuarioWorkspace_Email` (`Email`);
ALTER TABLE `ConviteUsuarioWorkspace` ADD INDEX `IX_ConviteUsuarioWorkspace_Token` (`Token`);
ALTER TABLE `ConviteUsuarioWorkspace` ADD INDEX `IX_ConviteUsuarioWorkspace_StatusConvite` (`StatusConvite`);
ALTER TABLE `ConviteUsuarioWorkspace` ADD INDEX `IX_ConviteUsuarioWorkspace_TokenExpiresAt` (`TokenExpiresAt`);

