module Generate exposing (main)

import Elm
import Gen.CodeGen.Generate as Generate
import Gen.GameObjectIds
import GenericDict


main : Program {} () ()
main =
    Generate.run
        [ personDictFile
        , dirtDictFile
        , relicDictFile
        ]


personDictFile : Elm.File
personDictFile =
    GenericDict.init
        { keyType = Gen.GameObjectIds.annotation_.personId
        , namespace = []
        , toComparable = Gen.GameObjectIds.personIdToInt
        }
        |> GenericDict.withTypeName "PersonDict"
        |> GenericDict.generateFile


dirtDictFile : Elm.File
dirtDictFile =
    GenericDict.init
        { keyType = Gen.GameObjectIds.annotation_.dirtId
        , namespace = []
        , toComparable = Gen.GameObjectIds.dirtIdToInt
        }
        |> GenericDict.withTypeName "DirtDict"
        |> GenericDict.generateFile


relicDictFile : Elm.File
relicDictFile =
    GenericDict.init
        { keyType = Gen.GameObjectIds.annotation_.relicId
        , namespace = []
        , toComparable = Gen.GameObjectIds.relicIdToInt
        }
        |> GenericDict.withTypeName "RelicDict"
        |> GenericDict.generateFile
