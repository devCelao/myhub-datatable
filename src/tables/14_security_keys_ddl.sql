-- =====================================================
-- 14 - JWKS - Tabela de Chaves de Segurança
-- =====================================================
-- Tabela para armazenar chaves JWKS (JSON Web Key Set)
-- Suporta rotação automática de chaves para maior segurança
-- =====================================================

-- Tabela
CREATE TABLE IF NOT EXISTS `SecurityKeys` (
  `Id` CHAR(36) NOT NULL,
  CONSTRAINT `PK_SecurityKeys` PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Colunas
ALTER TABLE `SecurityKeys` ADD COLUMN `KeyId` VARCHAR(100) NOT NULL;
ALTER TABLE `SecurityKeys` ADD COLUMN `Type` VARCHAR(50) NOT NULL;
ALTER TABLE `SecurityKeys` ADD COLUMN `Algorithm` VARCHAR(50) NOT NULL;
ALTER TABLE `SecurityKeys` ADD COLUMN `ParametersJson` TEXT NULL;
ALTER TABLE `SecurityKeys` ADD COLUMN `CreationDate` DATETIME NOT NULL;
ALTER TABLE `SecurityKeys` ADD COLUMN `ExpirationDate` DATETIME NOT NULL;
ALTER TABLE `SecurityKeys` ADD COLUMN `IsRevoked` TINYINT(1) NOT NULL DEFAULT 0;

-- Comentários
ALTER TABLE `SecurityKeys` COMMENT = 'Tabela de chaves JWKS para rotação automática e assinatura de JWT';
ALTER TABLE `SecurityKeys` MODIFY COLUMN `Id` CHAR(36) NOT NULL COMMENT 'Identificador único da chave (GUID)';
ALTER TABLE `SecurityKeys` MODIFY COLUMN `KeyId` VARCHAR(100) NOT NULL COMMENT 'ID da chave (kid) usado no JWT header';
ALTER TABLE `SecurityKeys` MODIFY COLUMN `Type` VARCHAR(50) NOT NULL COMMENT 'Tipo da chave: EC (Elliptic Curve), RSA, oct (HMAC)';
ALTER TABLE `SecurityKeys` MODIFY COLUMN `Algorithm` VARCHAR(50) NOT NULL COMMENT 'Algoritmo de assinatura: ES256, RS256, HS256, etc';
ALTER TABLE `SecurityKeys` MODIFY COLUMN `ParametersJson` TEXT NULL COMMENT 'Parâmetros da chave em formato JSON (JsonWebKey serializado)';
ALTER TABLE `SecurityKeys` MODIFY COLUMN `CreationDate` DATETIME NOT NULL COMMENT 'Data e hora de criação da chave';
ALTER TABLE `SecurityKeys` MODIFY COLUMN `ExpirationDate` DATETIME NOT NULL COMMENT 'Data e hora de expiração (após essa data, não assina novos tokens)';
ALTER TABLE `SecurityKeys` MODIFY COLUMN `IsRevoked` TINYINT(1) NOT NULL DEFAULT 0 COMMENT 'Indica se a chave foi revogada manualmente';

-- Constraints e Índices
ALTER TABLE `SecurityKeys` ADD INDEX `IX_SecurityKeys_KeyId` (`KeyId`);
ALTER TABLE `SecurityKeys` ADD INDEX `IX_SecurityKeys_CreationDate` (`CreationDate`);
ALTER TABLE `SecurityKeys` ADD INDEX `IX_SecurityKeys_ExpirationDate` (`ExpirationDate`);
ALTER TABLE `SecurityKeys` ADD INDEX `IX_SecurityKeys_IsRevoked` (`IsRevoked`);

-- =====================================================
-- Observações:
-- =====================================================
-- 1. A chave privada é armazenada inicialmente no ParametersJson
-- 2. Após o período de rotação, a chave privada é removida (mantém apenas pública)
-- 3. Chaves públicas antigas permanecem para validar tokens ainda válidos
-- 4. A rotação de chaves acontece automaticamente conforme configuração
-- 5. Endpoint JWKS expõe apenas as chaves públicas (.well-known/jwks.json)
-- =====================================================

