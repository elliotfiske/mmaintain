module Evergreen.V6.PersonDict exposing (..)

import Dict
import Evergreen.V6.GameObjectIds


type PersonDict v
    = PersonDict (Dict.Dict Int ( Evergreen.V6.GameObjectIds.PersonId, v ))
