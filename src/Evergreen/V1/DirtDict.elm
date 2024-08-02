module Evergreen.V1.DirtDict exposing (..)

import Dict
import Evergreen.V1.GameObjectTypes


type DirtDict v
    = DirtDict (Dict.Dict Int ( Evergreen.V1.GameObjectTypes.DirtId, v ))
