-- =====================================================
-- 05 - PROFILE - Tabela de Permissões
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `Permissao` (
  `IdPermissao` CHAR(36) NOT NULL,
  CONSTRAINT `PK_Permissao` PRIMARY KEY (`IdPermissao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `Permissao` ADD COLUMN `NomePermissao` VARCHAR(100) NOT NULL;
ALTER TABLE `Permissao` ADD COLUMN `Descricao` VARCHAR(500) NULL;

-- Comentários
ALTER TABLE `Permissao` COMMENT = 'Tabela de permissões do sistema';
ALTER TABLE `Permissao` MODIFY COLUMN `IdPermissao` CHAR(36) NOT NULL COMMENT 'Identificador único da permissão';
ALTER TABLE `Permissao` MODIFY COLUMN `NomePermissao` VARCHAR(100) NOT NULL COMMENT 'Nome da permissão (ex: usuarios.ler)';
ALTER TABLE `Permissao` MODIFY COLUMN `Descricao` VARCHAR(500) NULL COMMENT 'Descrição da permissão';

-- Constraints e Índices
ALTER TABLE `Permissao` ADD CONSTRAINT `UK_Permissao_Nome` UNIQUE (`NomePermissao`);
ALTER TABLE `Permissao` ADD INDEX `IX_Permissao_Nome` (`NomePermissao`);

