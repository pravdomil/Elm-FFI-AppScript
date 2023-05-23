module AppScript.Script exposing (..)

import AppScript.Spreadsheet
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


spreadsheetTriggers : AppScript.Spreadsheet.Spreadsheet -> Task.Task JavaScript.Error (List Trigger)
spreadsheetTriggers (AppScript.Spreadsheet.Spreadsheet a) =
    JavaScript.run
        "ScriptApp.getUserTriggers(a)"
        a
        (Json.Decode.list (Json.Decode.map Trigger Json.Decode.value))
