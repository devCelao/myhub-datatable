-- =====================================================
-- 17 - PLANOSERVICO - Tabela de Serviços dos Planos
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `PlanoServico` (
  `CodPlano` VARCHAR(20) NOT NULL,
  `CodServico` VARCHAR(20) NOT NULL,
  CONSTRAINT `PK_PlanoServico` PRIMARY KEY (`CodPlano`, `CodServico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Comentários
ALTER TABLE `PlanoServico` COMMENT = 'Tabela de Serviços dos Planos';
ALTER TABLE `PlanoServico` MODIFY COLUMN `CodPlano` VARCHAR(20) NOT NULL COMMENT 'Codigo do plano (Chave Primaria)';
ALTER TABLE `PlanoServico` MODIFY COLUMN `CodServico` VARCHAR(20) NOT NULL COMMENT 'Codigo do serviço (Chave Primaria)';

-- Constraints e Índices
ALTER TABLE `PlanoServico` ADD CONSTRAINT `FK_Plano_CodPlano` FOREIGN KEY (`CodPlano`) REFERENCES `Plano` (`CodPlano`) ON DELETE CASCADE;
ALTER TABLE `PlanoServico` ADD CONSTRAINT `FK_Servico_CodServico` FOREIGN KEY (`CodServico`) REFERENCES `Servico` (`CodServico`) ON DELETE CASCADE;

