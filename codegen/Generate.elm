module Generate exposing (main)

import Elm
import Gen.CodeGen.Generate as Generate
import Gen.GameObjectTypes
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
        { keyType = Gen.GameObjectTypes.annotation_.personId
        , namespace = []
        , toComparable = Gen.GameObjectTypes.personIdToInt
        }
        |> GenericDict.withTypeName "PersonDict"
        |> GenericDict.generateFile


dirtDictFile : Elm.File
dirtDictFile =
    GenericDict.init
        { keyType = Gen.GameObjectTypes.annotation_.dirtId
        , namespace = []
        , toComparable = Gen.GameObjectTypes.dirtIdToInt
        }
        |> GenericDict.withTypeName "DirtDict"
        |> GenericDict.generateFile


relicDictFile : Elm.File
relicDictFile =
    GenericDict.init
        { keyType = Gen.GameObjectTypes.annotation_.relicId
        , namespace = []
        , toComparable = Gen.GameObjectTypes.relicIdToInt
        }
        |> GenericDict.withTypeName "RelicDict"
        |> GenericDict.generateFile
