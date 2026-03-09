-- =====================================================
-- 01 - IDENTITY - Tabela de Usuários
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `Usuario` (
  `IdUsuario` CHAR(36) NOT NULL,
  CONSTRAINT `PK_Usuario` PRIMARY KEY (`IdUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `Usuario` ADD COLUMN `NomeUsuario` VARCHAR(200) NULL;
ALTER TABLE `Usuario` ADD COLUMN `Email` VARCHAR(256) NULL;
ALTER TABLE `Usuario` ADD COLUMN `Cpf` VARCHAR(14) NULL;
ALTER TABLE `Usuario` ADD COLUMN `IndAceitaConvite` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `Usuario` ADD COLUMN `ContaAtivada` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `Usuario` ADD COLUMN `DataAtivacao` DATETIME NULL;

-- Comentários
ALTER TABLE `Usuario` COMMENT = 'Tabela de usuários globais da plataforma';
ALTER TABLE `Usuario` MODIFY COLUMN `IdUsuario` CHAR(36) NOT NULL COMMENT 'Identificador único do usuário';
ALTER TABLE `Usuario` MODIFY COLUMN `NomeUsuario` VARCHAR(200) NULL COMMENT 'Nome completo do usuário';
ALTER TABLE `Usuario` MODIFY COLUMN `Email` VARCHAR(256) NULL COMMENT 'Email do usuário (único)';
ALTER TABLE `Usuario` MODIFY COLUMN `Cpf` VARCHAR(14) NULL COMMENT 'CPF do usuário';
ALTER TABLE `Usuario` MODIFY COLUMN `IndAceitaConvite` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se o usuário aceita convites para outros workspaces';
ALTER TABLE `Usuario` MODIFY COLUMN `ContaAtivada` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se a conta foi ativada via email';
ALTER TABLE `Usuario` MODIFY COLUMN `DataAtivacao` DATETIME NULL COMMENT 'Data de ativação da conta';

-- Constraints e Índices
ALTER TABLE `Usuario` ADD CONSTRAINT `UK_Usuario_Email` UNIQUE (`Email`);
ALTER TABLE `Usuario` ADD INDEX `IX_Usuario_Email` (`Email`);
ALTER TABLE `Usuario` ADD INDEX `IX_Usuario_ContaAtivada` (`ContaAtivada`);

