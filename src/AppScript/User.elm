module AppScript.User exposing (..)

import JavaScript
import Json.Decode
import Task


type User
    = User Json.Decode.Value


name : User -> Task.Task JavaScript.Error String
name (User a) =
    JavaScript.run
        "a.getName()"
        a
        Json.Decode.string


email : User -> Task.Task JavaScript.Error String
email (User a) =
    JavaScript.run
        "a.getEmail()"
        a
        Json.Decode.string
