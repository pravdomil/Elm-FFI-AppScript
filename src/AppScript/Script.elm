module AppScript.Script exposing (..)

import JavaScript
import Json.Decode
import Json.Encode
import Task


type Trigger
    = Trigger Json.Decode.Value


projectTriggers : Task.Task JavaScript.Error (List Trigger)
projectTriggers =
    JavaScript.run
        "ScriptApp.getProjectTriggers()"
        Json.Encode.null
        (Json.Decode.list (Json.Decode.map Trigger Json.Decode.value))
