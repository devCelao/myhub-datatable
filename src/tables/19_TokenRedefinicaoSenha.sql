-- =====================================================
-- 19 - AUTHENTICATION - Tabela de Tokens de Redefinição de Senha
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `TokenRedefinicaoSenha` (
  `Id` CHAR(36) NOT NULL,
  CONSTRAINT `PK_TokenRedefinicaoSenha` PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `IdUsuario` CHAR(36) NOT NULL;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `Email` VARCHAR(256) NOT NULL;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `CodigoHash` VARCHAR(100) NOT NULL;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `DataCriacao` DATETIME(6) NOT NULL;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `DataExpiracao` DATETIME(6) NOT NULL;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `IndUtilizado` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `DataUtilizacao` DATETIME(6) NULL;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `IpSolicitacao` VARCHAR(45) NOT NULL;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `UserAgent` VARCHAR(500) NULL;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `IpUtilizacao` VARCHAR(45) NULL;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `TentativasInvalidas` INT NOT NULL DEFAULT 0;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `DataUltimaTentativa` DATETIME(6) NULL;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 1;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `DataInativacao` DATETIME(6) NULL;
ALTER TABLE `TokenRedefinicaoSenha` ADD COLUMN `MotivoInativacao` VARCHAR(500) NULL;

-- Comentários
ALTER TABLE `TokenRedefinicaoSenha` COMMENT = 'Códigos de verificação (6 dígitos) para redefinição de senha com controle de segurança';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `Id` CHAR(36) NOT NULL COMMENT 'Identificador único do código';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `IdUsuario` CHAR(36) NOT NULL COMMENT 'FK para AcessoUsuario';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `Email` VARCHAR(256) NOT NULL COMMENT 'Email do usuário (validação adicional)';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `CodigoHash` VARCHAR(100) NOT NULL COMMENT 'Hash SHA256 do código de 6 dígitos (nunca armazenar em texto plano)';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `DataCriacao` DATETIME(6) NOT NULL COMMENT 'Data/hora de criação do código';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `DataExpiracao` DATETIME(6) NOT NULL COMMENT 'Data/hora de expiração (padrão: 30 minutos)';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `IndUtilizado` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Código já foi utilizado?';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `DataUtilizacao` DATETIME(6) NULL COMMENT 'Quando o código foi utilizado';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `IpSolicitacao` VARCHAR(45) NOT NULL COMMENT 'IP de onde foi solicitado (suporta IPv6)';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `UserAgent` VARCHAR(500) NULL COMMENT 'User Agent do browser/app';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `IpUtilizacao` VARCHAR(45) NULL COMMENT 'IP de onde foi utilizado';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `TentativasInvalidas` INT NOT NULL DEFAULT 0 COMMENT 'Contador de tentativas inválidas (máx: 5)';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `DataUltimaTentativa` DATETIME(6) NULL COMMENT 'Data da última tentativa de uso';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Código está ativo?';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `DataInativacao` DATETIME(6) NULL COMMENT 'Quando foi inativado';
ALTER TABLE `TokenRedefinicaoSenha` MODIFY COLUMN `MotivoInativacao` VARCHAR(500) NULL COMMENT 'Motivo da inativação';

-- Constraints e Índices
ALTER TABLE `TokenRedefinicaoSenha` ADD CONSTRAINT `FK_TokenRedefinicaoSenha_AcessoUsuario` FOREIGN KEY (`IdUsuario`) REFERENCES `AcessoUsuario` (`IdUsuario`) ON DELETE CASCADE;
ALTER TABLE `TokenRedefinicaoSenha` ADD INDEX `IX_TokenRedefinicaoSenha_CodigoHash` (`CodigoHash`);
ALTER TABLE `TokenRedefinicaoSenha` ADD INDEX `IX_TokenRedefinicaoSenha_IdUsuario` (`IdUsuario`);
ALTER TABLE `TokenRedefinicaoSenha` ADD INDEX `IX_TokenRedefinicaoSenha_Email` (`Email`);
ALTER TABLE `TokenRedefinicaoSenha` ADD INDEX `IX_TokenRedefinicaoSenha_DataExpiracao` (`DataExpiracao`);
ALTER TABLE `TokenRedefinicaoSenha` ADD INDEX `IX_TokenRedefinicaoSenha_IndAtivo` (`IndAtivo`);
ALTER TABLE `TokenRedefinicaoSenha` ADD INDEX `IX_TokenRedefinicaoSenha_IndUtilizado` (`IndUtilizado`);
ALTER TABLE `TokenRedefinicaoSenha` ADD INDEX `IX_TokenRedefinicaoSenha_Limpeza` (`DataExpiracao`, `IndUtilizado`, `IndAtivo`);

