module AppScript.Document exposing (..)

import JavaScript
import Json.Decode
import Json.Encode
import Task


type Document
    = Document Json.Decode.Value


active : Task.Task JavaScript.Error (Maybe Document)
active =
    JavaScript.run
        "DocumentApp.getActiveDocument()"
        Json.Encode.null
        (Json.Decode.oneOf
            [ Json.Decode.null Nothing
            , Json.Decode.map (Document >> Just) Json.Decode.value
            ]
        )


name : Document -> Task.Task JavaScript.Error String
name (Document a) =
    JavaScript.run
        "a.getName()"
        a
        Json.Decode.string
