module Console exposing (..)

import JavaScript
import Json.Decode
import Json.Encode
import Task


log : String -> Task.Task JavaScript.Error ()
log a =
    JavaScript.run "console.log(a)"
        (Json.Encode.string a)
        (Json.Decode.succeed ())


logInfo : String -> Task.Task JavaScript.Error ()
logInfo a =
    JavaScript.run "console.info(a)"
        (Json.Encode.string a)
        (Json.Decode.succeed ())


logWarning : String -> Task.Task JavaScript.Error ()
logWarning a =
    JavaScript.run "console.warn(a)"
        (Json.Encode.string a)
        (Json.Decode.succeed ())


logError : String -> Task.Task JavaScript.Error ()
logError a =
    JavaScript.run "console.error(a)"
        (Json.Encode.string a)
        (Json.Decode.succeed ())
