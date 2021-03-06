{-# options_ghc -fno-warn-missing-signatures #-}
{-# language OverloadedStrings #-}
{-# language TypeApplications #-}
-- Intentionally don't export any easy way to construct ids
module Planetary.Support.Ids
  ( intId
  , boolId
  , concatStrsId
  , orId
  , andId
  , unitId
  , valueTyUid
  , computationTyUid
  , pegUid
  , tyVarUid
  , tyArgUid
  , polyTyUid
  , abilityUid
  , adjustmentUid
  , tyEnvUid
  , useUid
  , constructionUid
  , spineUid
  , uidUid
  , voidUid
  , idUid
  , uidOpsId
  , uidId
  , textId
  , consoleId
  , charHandlerId
  , vectorId
  , uidMapId
  , syntaxOpsId
  , rowId
  , tupleId
  ) where

import Data.Byteable (toBytes)
import Data.ByteString (ByteString)
import Crypto.Hash
import Network.IPLD as IPLD

seed :: ByteString
seed = "we who cut mere stones must always be envisioning cathedrals"

-- Something fast but not secure
type D = Digest SHA1

generateCids :: [Cid]
generateCids = mkCid . toBytes @D . hashFinalize <$>
  iterate (`hashUpdate` seed) hashInit

intId
  : boolId
  : concatStrsId
  : orId
  : andId
  : unitId
  : valueTyUid
  : computationTyUid
  : pegUid
  : tyVarUid
  : tyArgUid
  : polyTyUid
  : abilityUid
  : adjustmentUid
  : tyEnvUid
  : useUid
  : constructionUid
  : spineUid
  : uidUid
  : voidUid
  : idUid
  : uidOpsId
  : uidId
  : textId
  : consoleId
  : charHandlerId
  : vectorId
  : uidMapId
  : syntaxOpsId
  : rowId
  : tupleId
  :_ = generateCids
