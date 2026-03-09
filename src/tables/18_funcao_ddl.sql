-- =====================================================
-- 18 - Funcao - Tabela de Funções de Serviços
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `Funcao` (
  `CodFuncao` VARCHAR(20) NOT NULL,
  `CodServico` VARCHAR(20) NOT NULL,
  CONSTRAINT `PK_Funcao` PRIMARY KEY (`CodFuncao`, `CodServico`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `Funcao` ADD COLUMN `Label` VARCHAR(100) NOT NULL;
ALTER TABLE `Funcao` ADD COLUMN `Descricao` VARCHAR(500) NULL;
ALTER TABLE `Funcao` ADD COLUMN `Icone` VARCHAR(50) NULL;
ALTER TABLE `Funcao` ADD COLUMN `NumOrdem` INT NOT NULL DEFAULT 0;
ALTER TABLE `Funcao` ADD COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 1;

-- Comentários
ALTER TABLE `Funcao` COMMENT = 'Tabela de Funções dos Serviços';
ALTER TABLE `Funcao` MODIFY COLUMN `CodFuncao` VARCHAR(20) NOT NULL COMMENT 'Codigo da função (Chave Primaria)';
ALTER TABLE `Funcao` MODIFY COLUMN `CodServico` VARCHAR(20) NOT NULL COMMENT 'Codigo do serviço (Chave Estrangeira)';
ALTER TABLE `Funcao` MODIFY COLUMN `Label` VARCHAR(100) NOT NULL COMMENT 'Label da função';
ALTER TABLE `Funcao` MODIFY COLUMN `Descricao` VARCHAR(500) NULL COMMENT 'Descrição da função';
ALTER TABLE `Funcao` MODIFY COLUMN `Icone` VARCHAR(50) NULL COMMENT 'Ícone da função';
ALTER TABLE `Funcao` MODIFY COLUMN `NumOrdem` INT NOT NULL DEFAULT 0 COMMENT 'Ordem de exibição';
ALTER TABLE `Funcao` MODIFY COLUMN `IndAtivo` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Indicador se a função está ativa';

-- Constraints e Índices
ALTER TABLE `Funcao` ADD CONSTRAINT `FK_Funcao_Servico` FOREIGN KEY (`CodServico`) REFERENCES `Servico` (`CodServico`) ON DELETE CASCADE;
ALTER TABLE `Funcao` ADD CONSTRAINT `UK_Funcao_CodServico_Label` UNIQUE (`CodFuncao`, `CodServico`, `Label`);
ALTER TABLE `Funcao` ADD INDEX `IX_Funcao_CodServico` (`CodServico`);
ALTER TABLE `Funcao` ADD INDEX `IX_Funcao_NumOrdem` (`NumOrdem`);

