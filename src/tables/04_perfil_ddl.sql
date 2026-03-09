-- =====================================================
-- 04 - PROFILE - Tabela de Perfis
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `Perfil` (
  `IdPerfil` CHAR(36) NOT NULL,
  CONSTRAINT `PK_Perfil` PRIMARY KEY (`IdPerfil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `Perfil` ADD COLUMN `IdWorkspace` CHAR(36) NOT NULL;
ALTER TABLE `Perfil` ADD COLUMN `TituloPerfil` VARCHAR(100) NOT NULL;
ALTER TABLE `Perfil` ADD COLUMN `Descricao` VARCHAR(500) NULL;
ALTER TABLE `Perfil` ADD COLUMN `Posicao` INT NOT NULL DEFAULT 0;
ALTER TABLE `Perfil` ADD COLUMN `Cor` VARCHAR(20) NULL;
ALTER TABLE `Perfil` ADD COLUMN `Destacavel` TINYINT(1) NOT NULL DEFAULT 0;

-- Comentários
ALTER TABLE `Perfil` COMMENT = 'Tabela de perfis de acesso dos workspaces';
ALTER TABLE `Perfil` MODIFY COLUMN `IdPerfil` CHAR(36) NOT NULL COMMENT 'Identificador único do perfil';
ALTER TABLE `Perfil` MODIFY COLUMN `IdWorkspace` CHAR(36) NOT NULL COMMENT 'FK para Workspace';
ALTER TABLE `Perfil` MODIFY COLUMN `TituloPerfil` VARCHAR(100) NOT NULL COMMENT 'Título do perfil';
ALTER TABLE `Perfil` MODIFY COLUMN `Descricao` VARCHAR(500) NULL COMMENT 'Descrição do perfil';
ALTER TABLE `Perfil` MODIFY COLUMN `Posicao` INT NOT NULL DEFAULT 0 COMMENT 'Posição na hierarquia (ordem)';
ALTER TABLE `Perfil` MODIFY COLUMN `Cor` VARCHAR(20) NULL COMMENT 'Cor do perfil em hexadecimal';
ALTER TABLE `Perfil` MODIFY COLUMN `Destacavel` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se o perfil pode ser destacado';

-- Constraints e Índices
ALTER TABLE `Perfil` ADD CONSTRAINT `FK_Perfil_Workspace` FOREIGN KEY (`IdWorkspace`) REFERENCES `Workspace` (`IdWorkspace`) ON DELETE CASCADE;
ALTER TABLE `Perfil` ADD INDEX `IX_Perfil_IdWorkspace` (`IdWorkspace`);
ALTER TABLE `Perfil` ADD INDEX `IX_Perfil_Posicao` (`Posicao`);

