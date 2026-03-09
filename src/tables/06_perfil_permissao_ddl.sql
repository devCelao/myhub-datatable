-- =====================================================
-- 06 - PROFILE - Tabela de Vínculo Perfil-Permissão
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `PerfilPermissao` (
  `IdPerfil` CHAR(36) NOT NULL,
  `IdPermissao` CHAR(36) NOT NULL,
  CONSTRAINT `PK_PerfilPermissao` PRIMARY KEY (`IdPerfil`, `IdPermissao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Comentários
ALTER TABLE `PerfilPermissao` COMMENT = 'Tabela de vínculo N:N entre perfis e permissões';
ALTER TABLE `PerfilPermissao` MODIFY COLUMN `IdPerfil` CHAR(36) NOT NULL COMMENT 'FK para Perfil';
ALTER TABLE `PerfilPermissao` MODIFY COLUMN `IdPermissao` CHAR(36) NOT NULL COMMENT 'FK para Permissao';

-- Constraints e Índices
ALTER TABLE `PerfilPermissao` ADD CONSTRAINT `FK_PerfilPermissao_Perfil` FOREIGN KEY (`IdPerfil`) REFERENCES `Perfil` (`IdPerfil`) ON DELETE CASCADE;
ALTER TABLE `PerfilPermissao` ADD CONSTRAINT `FK_PerfilPermissao_Permissao` FOREIGN KEY (`IdPermissao`) REFERENCES `Permissao` (`IdPermissao`) ON DELETE CASCADE;
ALTER TABLE `PerfilPermissao` ADD INDEX `IX_PerfilPermissao_IdPerfil` (`IdPerfil`);
ALTER TABLE `PerfilPermissao` ADD INDEX `IX_PerfilPermissao_IdPermissao` (`IdPermissao`);

