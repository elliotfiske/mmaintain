module Evergreen.V6.RelicDict exposing (..)

import Dict
import Evergreen.V6.GameObjectIds


type RelicDict v
    = RelicDict (Dict.Dict Int ( Evergreen.V6.GameObjectIds.RelicId, v ))
