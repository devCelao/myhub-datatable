-- =====================================================
-- 07 - ORGANIZATION - Tabela de Vínculo UsuarioWorkspace-Perfil
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `UsuarioWorkspacePerfil` (
  `IdUsuarioWorkspace` CHAR(36) NOT NULL,
  `IdPerfil` CHAR(36) NOT NULL,
  CONSTRAINT `PK_UsuarioWorkspacePerfil` PRIMARY KEY (`IdUsuarioWorkspace`, `IdPerfil`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `UsuarioWorkspacePerfil` ADD COLUMN `DataAtribuicao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

-- Comentários
ALTER TABLE `UsuarioWorkspacePerfil` COMMENT = 'Tabela de vínculo N:N entre usuários-workspace e perfis';
ALTER TABLE `UsuarioWorkspacePerfil` MODIFY COLUMN `IdUsuarioWorkspace` CHAR(36) NOT NULL COMMENT 'FK para UsuarioWorkspace';
ALTER TABLE `UsuarioWorkspacePerfil` MODIFY COLUMN `IdPerfil` CHAR(36) NOT NULL COMMENT 'FK para Perfil';
ALTER TABLE `UsuarioWorkspacePerfil` MODIFY COLUMN `DataAtribuicao` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de atribuição do perfil';

-- Constraints e Índices
ALTER TABLE `UsuarioWorkspacePerfil` ADD CONSTRAINT `FK_UsuarioWorkspacePerfil_UsuarioWorkspace` FOREIGN KEY (`IdUsuarioWorkspace`) REFERENCES `UsuarioWorkspace` (`IdUsuarioWorkspace`) ON DELETE CASCADE;
ALTER TABLE `UsuarioWorkspacePerfil` ADD CONSTRAINT `FK_UsuarioWorkspacePerfil_Perfil` FOREIGN KEY (`IdPerfil`) REFERENCES `Perfil` (`IdPerfil`) ON DELETE RESTRICT;
ALTER TABLE `UsuarioWorkspacePerfil` ADD INDEX `IX_UsuarioWorkspacePerfil_IdUsuarioWorkspace` (`IdUsuarioWorkspace`);
ALTER TABLE `UsuarioWorkspacePerfil` ADD INDEX `IX_UsuarioWorkspacePerfil_IdPerfil` (`IdPerfil`);

