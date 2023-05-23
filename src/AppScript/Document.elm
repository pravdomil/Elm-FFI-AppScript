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


create : String -> Task.Task JavaScript.Error Document
create a =
    JavaScript.run
        "DocumentApp.create(a)"
        (Json.Encode.string a)
        (Json.Decode.map Document Json.Decode.value)


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


appendParagraph : Paragraph -> Body -> Task.Task JavaScript.Error ()
appendParagraph (Paragraph paragraph) (Body a) =
    JavaScript.run
        "a[1].appendParagraph(a[0]])"
        (Json.Encode.list identity [ paragraph, a ])
        (Json.Decode.succeed ())



--


type Element
    = Element Json.Decode.Value


elements : Body -> Task.Task JavaScript.Error (List Element)
elements (Body a) =
    JavaScript.run
        "(function() { var acc = []; for (var i = 0; i < a.getNumChildren(); i++) acc.push(a.getChild(i)); return acc })()"
        a
        (Json.Decode.list (Json.Decode.map Element Json.Decode.value))


type_ : Element -> Task.Task JavaScript.Error String
type_ (Element a) =
    JavaScript.run
        "a.getType().toString()"
        a
        Json.Decode.string


toParagraph : Element -> Task.Task JavaScript.Error (Maybe Paragraph)
toParagraph (Element a) =
    JavaScript.run
        "(a.getType() == DocumentApp.ElementType.PARAGRAPH ? a : null)"
        a
        (Json.Decode.oneOf
            [ Json.Decode.null Nothing
            , Json.Decode.map (Paragraph >> Just) Json.Decode.value
            ]
        )



--


type Paragraph
    = Paragraph Json.Decode.Value


text : Paragraph -> Task.Task JavaScript.Error String
text (Paragraph a) =
    JavaScript.run
        "a.getText()"
        a
        Json.Decode.string
