-- =====================================================
-- 15 - PLANO - Tabela de Planos
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `Plano` (
  `CodPlano` VARCHAR(10) NOT NULL,
  CONSTRAINT `PK_Plano` PRIMARY KEY (`CodPlano`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `Plano` ADD COLUMN `NomePlano` VARCHAR(500) NULL;
ALTER TABLE `Plano` ADD COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `Plano` ADD COLUMN `IndGeraCobranca` TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE `Plano` ADD COLUMN `ValorBase` DECIMAL(10,2) NOT NULL DEFAULT 0.00;

-- Comentários
ALTER TABLE `Plano` COMMENT = 'Tabela de Planos';
ALTER TABLE `Plano` MODIFY COLUMN `CodPlano` VARCHAR(10) NOT NULL COMMENT 'Codigo do plano (Chave Primaria)';
ALTER TABLE `Plano` MODIFY COLUMN `NomePlano` VARCHAR(500) NULL COMMENT 'Título do plano';
ALTER TABLE `Plano` MODIFY COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se o plano está ativo (1) ou inativo (0)';
ALTER TABLE `Plano` MODIFY COLUMN `IndGeraCobranca` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se o plano gera cobrança (1) ou não (0)';
ALTER TABLE `Plano` MODIFY COLUMN `ValorBase` DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Valor base do plano';

-- Constraints e Índices
ALTER TABLE `Plano` ADD INDEX `IX_Plano_NomePlano` (`NomePlano`);
ALTER TABLE `Plano` ADD INDEX `IX_Plano_IndAtivo` (`IndAtivo`);

