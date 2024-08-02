module Evergreen.V1.PersonDict exposing (..)

import Dict
import Evergreen.V1.GameObjectTypes


type PersonDict v
    = PersonDict (Dict.Dict Int ( Evergreen.V1.GameObjectTypes.PersonId, v ))
