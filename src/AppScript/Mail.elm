module AppScript.Mail exposing (..)

import JavaScript
import Json.Decode
import Json.Encode
import Task


send : String -> String -> String -> Task.Task JavaScript.Error ()
send email subject body =
    JavaScript.run
        "MailApp.sendEmail(a[0], a[1], a[2], {})"
        (Json.Encode.list Json.Encode.string [ email, subject, body ])
        (Json.Decode.succeed ())
