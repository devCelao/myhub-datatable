-- =====================================================
-- 12 - AUTHENTICATION - Tabela de Acesso de Usuários
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `AcessoUsuario` (
  `IdUsuario` CHAR(36) NOT NULL,
  CONSTRAINT `PK_AcessoUsuario` PRIMARY KEY (`IdUsuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `AcessoUsuario` ADD COLUMN `Email` VARCHAR(256) NOT NULL;
ALTER TABLE `AcessoUsuario` ADD COLUMN `SenhaCrypto` VARCHAR(512) NOT NULL;
ALTER TABLE `AcessoUsuario` ADD COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 1;
ALTER TABLE `AcessoUsuario` ADD COLUMN `IndTrocaSenha` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `AcessoUsuario` ADD COLUMN `DataCadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `AcessoUsuario` ADD COLUMN `IndDoisFatoresAtivo` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `AcessoUsuario` ADD COLUMN `QtdTentativasFalhas` INT NOT NULL DEFAULT 0;
ALTER TABLE `AcessoUsuario` ADD COLUMN `TipoBloqueio` INT NOT NULL DEFAULT 0;
ALTER TABLE `AcessoUsuario` ADD COLUMN `DataBloqueio` DATETIME NULL;
ALTER TABLE `AcessoUsuario` ADD COLUMN `DataFimBloqueio` DATETIME NULL;
ALTER TABLE `AcessoUsuario` ADD COLUMN `MotivoBloqueio` VARCHAR(500) NULL;
ALTER TABLE `AcessoUsuario` ADD COLUMN `IdUsuarioBloqueio` CHAR(36) NULL;
ALTER TABLE `AcessoUsuario` ADD COLUMN `DataUltimoAcesso` DATETIME NULL;
ALTER TABLE `AcessoUsuario` ADD COLUMN `IpUltimoAcesso` VARCHAR(45) NULL;
ALTER TABLE `AcessoUsuario` ADD COLUMN `DataUltimaTrocaSenha` DATETIME NULL;
ALTER TABLE `AcessoUsuario` ADD COLUMN `VersaoSenha` INT NOT NULL DEFAULT 1;

-- Comentários
ALTER TABLE `AcessoUsuario` COMMENT = 'Tabela de controle de acesso e autenticação de usuários';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `IdUsuario` CHAR(36) NOT NULL COMMENT 'Identificador único do usuário (FK para Usuario)';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `Email` VARCHAR(256) NOT NULL COMMENT 'Email do usuário (único)';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `SenhaCrypto` VARCHAR(512) NOT NULL COMMENT 'Senha criptografada';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Indica se a conta está ativa';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `IndTrocaSenha` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se o usuário deve trocar a senha no próximo login';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `DataCadastro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Data de cadastro da conta';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `IndDoisFatoresAtivo` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se a autenticação de dois fatores está ativa';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `QtdTentativasFalhas` INT NOT NULL DEFAULT 0 COMMENT 'Quantidade de tentativas falhas de login';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `TipoBloqueio` INT NOT NULL DEFAULT 0 COMMENT 'Tipo de bloqueio: 0=Nenhum, 1=TemporarioTentativas, 2=ManualTemporario, 3=ManualPermanente, 4=SuspeitaFraude, 5=InativoPorTempo';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `DataBloqueio` DATETIME NULL COMMENT 'Data em que a conta foi bloqueada';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `DataFimBloqueio` DATETIME NULL COMMENT 'Data de término do bloqueio temporário';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `MotivoBloqueio` VARCHAR(500) NULL COMMENT 'Motivo do bloqueio';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `IdUsuarioBloqueio` CHAR(36) NULL COMMENT 'ID do administrador que bloqueou (se bloqueio manual)';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `DataUltimoAcesso` DATETIME NULL COMMENT 'Data do último acesso bem-sucedido';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `IpUltimoAcesso` VARCHAR(45) NULL COMMENT 'IP do último acesso (IPv4 ou IPv6)';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `DataUltimaTrocaSenha` DATETIME NULL COMMENT 'Data da última troca de senha';
ALTER TABLE `AcessoUsuario` MODIFY COLUMN `VersaoSenha` INT NOT NULL DEFAULT 1 COMMENT 'Versão da senha (incrementa a cada troca)';

-- Constraints e Índices
ALTER TABLE `AcessoUsuario` ADD CONSTRAINT `UK_AcessoUsuario_Email` UNIQUE (`Email`);
ALTER TABLE `AcessoUsuario` ADD INDEX `IX_AcessoUsuario_Email` (`Email`);
ALTER TABLE `AcessoUsuario` ADD INDEX `IX_AcessoUsuario_IndAtivo` (`IndAtivo`);
ALTER TABLE `AcessoUsuario` ADD INDEX `IX_AcessoUsuario_TipoBloqueio` (`TipoBloqueio`);
ALTER TABLE `AcessoUsuario` ADD INDEX `IX_AcessoUsuario_DataUltimoAcesso` (`DataUltimoAcesso`);
ALTER TABLE `AcessoUsuario` ADD INDEX `IX_AcessoUsuario_DataFimBloqueio` (`DataFimBloqueio`);

