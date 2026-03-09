-- =====================================================
-- 16 - Servico - Tabela de Servicos
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `Servico` (
  `CodServico` VARCHAR(20) NOT NULL,
  CONSTRAINT `PK_Servico` PRIMARY KEY (`CodServico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `Servico` ADD COLUMN `NomeServico` VARCHAR(100) NULL;
ALTER TABLE `Servico` ADD COLUMN `Descricao` VARCHAR(500) NULL;

-- Comentários
ALTER TABLE `Servico` COMMENT = 'Tabela de Serviços';
ALTER TABLE `Servico` MODIFY COLUMN `CodServico` VARCHAR(20) NOT NULL COMMENT 'Codigo do serviço (Chave Primaria)';
ALTER TABLE `Servico` MODIFY COLUMN `NomeServico` VARCHAR(100) NULL COMMENT 'Nome do serviço';
ALTER TABLE `Servico` MODIFY COLUMN `Descricao` VARCHAR(500) NULL COMMENT 'Descrição do serviço';

-- Constraints e Índices
ALTER TABLE `Servico` ADD CONSTRAINT `UK_Servico_NomeServico` UNIQUE (`NomeServico`);
ALTER TABLE `Servico` ADD INDEX `IX_Servico_NomeServico` (`NomeServico`);
ALTER TABLE `Servico` ADD INDEX `IX_Servico_Descricao` (`Descricao`);

