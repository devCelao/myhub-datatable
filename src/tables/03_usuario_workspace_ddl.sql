-- =====================================================
-- 03 - ORGANIZATION - Tabela de Vínculo Usuário-Workspace
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `UsuarioWorkspace` (
  `IdUsuarioWorkspace` CHAR(36) NOT NULL,
  CONSTRAINT `PK_UsuarioWorkspace` PRIMARY KEY (`IdUsuarioWorkspace`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `UsuarioWorkspace` ADD COLUMN `IdWorkspace` CHAR(36) NOT NULL;
ALTER TABLE `UsuarioWorkspace` ADD COLUMN `IdUsuario` CHAR(36) NOT NULL;
ALTER TABLE `UsuarioWorkspace` ADD COLUMN `StatusVinculo` INT NOT NULL DEFAULT 0;
ALTER TABLE `UsuarioWorkspace` ADD COLUMN `IndPadrao` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `UsuarioWorkspace` ADD COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 1;
ALTER TABLE `UsuarioWorkspace` ADD COLUMN `DataCriacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `UsuarioWorkspace` ADD COLUMN `IndAdmin` TINYINT(1) NOT NULL DEFAULT 0;

-- Comentários
ALTER TABLE `UsuarioWorkspace` COMMENT = 'Tabela de vínculo N:N entre usuários e workspaces';
ALTER TABLE `UsuarioWorkspace` MODIFY COLUMN `IdUsuarioWorkspace` CHAR(36) NOT NULL COMMENT 'Identificador único do vínculo';
ALTER TABLE `UsuarioWorkspace` MODIFY COLUMN `IdWorkspace` CHAR(36) NOT NULL COMMENT 'FK para Workspace';
ALTER TABLE `UsuarioWorkspace` MODIFY COLUMN `IdUsuario` CHAR(36) NOT NULL COMMENT 'FK para Usuario';
ALTER TABLE `UsuarioWorkspace` MODIFY COLUMN `StatusVinculo` INT NOT NULL DEFAULT 0 COMMENT 'Status do vínculo: 0=Ativo, 1=Inativo, 2=Suspenso';
ALTER TABLE `UsuarioWorkspace` MODIFY COLUMN `IndPadrao` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se é o workspace padrão do usuário';
ALTER TABLE `UsuarioWorkspace` MODIFY COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Indica se o vínculo está ativo';
ALTER TABLE `UsuarioWorkspace` MODIFY COLUMN `DataCriacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de criação do vínculo';
ALTER TABLE `UsuarioWorkspace` MODIFY COLUMN `IndAdmin` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se o usuário é administrador do workspace';

-- Constraints e Índices
ALTER TABLE `UsuarioWorkspace` ADD CONSTRAINT `FK_UsuarioWorkspace_Usuario` FOREIGN KEY (`IdUsuario`) REFERENCES `Usuario` (`IdUsuario`) ON DELETE CASCADE;
ALTER TABLE `UsuarioWorkspace` ADD CONSTRAINT `FK_UsuarioWorkspace_Workspace` FOREIGN KEY (`IdWorkspace`) REFERENCES `Workspace` (`IdWorkspace`) ON DELETE CASCADE;
ALTER TABLE `UsuarioWorkspace` ADD CONSTRAINT `UK_UsuarioWorkspace_Usuario_Workspace` UNIQUE (`IdUsuario`, `IdWorkspace`);
ALTER TABLE `UsuarioWorkspace` ADD INDEX `IX_UsuarioWorkspace_IdUsuario` (`IdUsuario`);
ALTER TABLE `UsuarioWorkspace` ADD INDEX `IX_UsuarioWorkspace_IdWorkspace` (`IdWorkspace`);
ALTER TABLE `UsuarioWorkspace` ADD INDEX `IX_UsuarioWorkspace_IndAtivo` (`IndAtivo`);
ALTER TABLE `UsuarioWorkspace` ADD INDEX `IX_UsuarioWorkspace_IndAdmin` (`IndAdmin`);

