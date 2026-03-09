-- =====================================================
-- 02 - ORGANIZATION - Tabela de Workspaces
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `Workspace` (
  `IdWorkspace` CHAR(36) NOT NULL,
  CONSTRAINT `PK_Workspace` PRIMARY KEY (`IdWorkspace`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `Workspace` ADD COLUMN `IdWorkspacePai` CHAR(36) NULL;
ALTER TABLE `Workspace` ADD COLUMN `NomeWorkspace` VARCHAR(200) NOT NULL;
ALTER TABLE `Workspace` ADD COLUMN `Slug` VARCHAR(200) NOT NULL;
ALTER TABLE `Workspace` ADD COLUMN `Dominio` VARCHAR(100) NULL;
ALTER TABLE `Workspace` ADD COLUMN `Plano` INT NOT NULL DEFAULT 0;
ALTER TABLE `Workspace` ADD COLUMN `LimiteFiliais` INT NOT NULL DEFAULT 0;
ALTER TABLE `Workspace` ADD COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 1;
ALTER TABLE `Workspace` ADD COLUMN `DataCriacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Comentários
ALTER TABLE `Workspace` COMMENT = 'Tabela de workspaces/organizações com suporte a hierarquia matriz/filial';
ALTER TABLE `Workspace` MODIFY COLUMN `IdWorkspace` CHAR(36) NOT NULL COMMENT 'Identificador único do workspace';
ALTER TABLE `Workspace` MODIFY COLUMN `IdWorkspacePai` CHAR(36) NULL COMMENT 'FK para Workspace matriz (NULL = workspace raiz)';
ALTER TABLE `Workspace` MODIFY COLUMN `NomeWorkspace` VARCHAR(200) NOT NULL COMMENT 'Nome do workspace';
ALTER TABLE `Workspace` MODIFY COLUMN `Slug` VARCHAR(200) NOT NULL COMMENT 'Identificador amigável para URLs (único)';
ALTER TABLE `Workspace` MODIFY COLUMN `Dominio` VARCHAR(100) NULL COMMENT 'Domínio customizado (white-label)';
ALTER TABLE `Workspace` MODIFY COLUMN `Plano` INT NOT NULL DEFAULT 0 COMMENT 'Plano de assinatura: 0=Free, 1=Basic, 2=Pro, 3=Enterprise';
ALTER TABLE `Workspace` MODIFY COLUMN `LimiteFiliais` INT NOT NULL DEFAULT 0 COMMENT 'Quantidade máxima de filiais permitidas (0 = sem permissão)';
ALTER TABLE `Workspace` MODIFY COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Indica se o workspace está ativo';
ALTER TABLE `Workspace` MODIFY COLUMN `DataCriacao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de criação do workspace';

-- Constraints e Índices
ALTER TABLE `Workspace` ADD CONSTRAINT `UK_Workspace_Slug` UNIQUE (`Slug`);
ALTER TABLE `Workspace` ADD CONSTRAINT `FK_Workspace_WorkspaceMatriz` FOREIGN KEY (`IdWorkspacePai`) REFERENCES `Workspace` (`IdWorkspace`) ON DELETE RESTRICT;
ALTER TABLE `Workspace` ADD INDEX `IX_Workspace_IdWorkspacePai` (`IdWorkspacePai`);
ALTER TABLE `Workspace` ADD INDEX `IX_Workspace_Slug` (`Slug`);
ALTER TABLE `Workspace` ADD INDEX `IX_Workspace_IndAtivo` (`IndAtivo`);
ALTER TABLE `Workspace` ADD INDEX `IX_Workspace_Plano` (`Plano`);

