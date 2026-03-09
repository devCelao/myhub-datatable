-- =====================================================
-- 09 - SUBSCRIPTION - Tabela de Assinaturas
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `Assinatura` (
  `IdAssinatura` CHAR(36) NOT NULL,
  CONSTRAINT `PK_Assinatura` PRIMARY KEY (`IdAssinatura`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `Assinatura` ADD COLUMN `IdWorkspace` CHAR(36) NOT NULL;
ALTER TABLE `Assinatura` ADD COLUMN `CodPlano` VARCHAR(50) NOT NULL;
ALTER TABLE `Assinatura` ADD COLUMN `DataInicio` DATETIME NOT NULL;
ALTER TABLE `Assinatura` ADD COLUMN `DataFim` DATETIME NULL;
ALTER TABLE `Assinatura` ADD COLUMN `IndAssinaturaAtiva` TINYINT(1) NOT NULL DEFAULT 1;

-- Comentários
ALTER TABLE `Assinatura` COMMENT = 'Tabela de assinaturas dos workspaces';
ALTER TABLE `Assinatura` MODIFY COLUMN `IdAssinatura` CHAR(36) NOT NULL COMMENT 'Identificador único da assinatura';
ALTER TABLE `Assinatura` MODIFY COLUMN `IdWorkspace` CHAR(36) NOT NULL COMMENT 'FK para Workspace';
ALTER TABLE `Assinatura` MODIFY COLUMN `CodPlano` VARCHAR(50) NOT NULL COMMENT 'Código do plano (Free, Basic, Pro, Enterprise)';
ALTER TABLE `Assinatura` MODIFY COLUMN `DataInicio` DATETIME NOT NULL COMMENT 'Data de início da assinatura';
ALTER TABLE `Assinatura` MODIFY COLUMN `DataFim` DATETIME NULL COMMENT 'Data de fim da assinatura';
ALTER TABLE `Assinatura` MODIFY COLUMN `IndAssinaturaAtiva` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Indica se a assinatura está ativa';

-- Constraints e Índices
ALTER TABLE `Assinatura` ADD CONSTRAINT `FK_Assinatura_Workspace` FOREIGN KEY (`IdWorkspace`) REFERENCES `Workspace` (`IdWorkspace`) ON DELETE CASCADE;
ALTER TABLE `Assinatura` ADD CONSTRAINT `UK_Assinatura_Workspace` UNIQUE (`IdWorkspace`);
ALTER TABLE `Assinatura` ADD INDEX `IX_Assinatura_IdWorkspace` (`IdWorkspace`);
ALTER TABLE `Assinatura` ADD INDEX `IX_Assinatura_IndAtiva` (`IndAssinaturaAtiva`);
ALTER TABLE `Assinatura` ADD INDEX `IX_Assinatura_DataFim` (`DataFim`);

