module AppScript.Fetch exposing (..)

import JavaScript
import Json.Decode
import Json.Encode
import Task


text : String -> Task.Task JavaScript.Error String
text a =
    JavaScript.run
        "UrlFetchApp.fetch(a).getContentText()"
        (Json.Encode.string a)
        Json.Decode.string


blob : String -> Task.Task JavaScript.Error Json.Decode.Value
blob a =
    JavaScript.run
        "UrlFetchApp.fetch(a).getBlob()"
        (Json.Encode.string a)
        Json.Decode.value
