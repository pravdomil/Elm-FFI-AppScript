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


byId : String -> Task.Task JavaScript.Error (Maybe Document)
byId a =
    JavaScript.run
        "DocumentApp.openById(a)"
        (Json.Encode.string a)
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



--


type Body
    = Body Json.Decode.Value


body : Document -> Task.Task JavaScript.Error Body
body (Document a) =
    JavaScript.run
        "a.getBody()"
        a
        (Json.Decode.map Body Json.Decode.value)
