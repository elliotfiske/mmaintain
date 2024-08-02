module Evergreen.V1.RelicDict exposing (..)

import Dict
import Evergreen.V1.GameObjectTypes


type RelicDict v
    = RelicDict (Dict.Dict Int ( Evergreen.V1.GameObjectTypes.RelicId, v ))
