module AppScript.Drive exposing (..)

import AppScript.User
import JavaScript
import Json.Decode
import Json.Encode
import Task


type Folder
    = Folder Json.Decode.Value


folderId : Folder -> Task.Task JavaScript.Error String
folderId (Folder a) =
    JavaScript.run
        "a.getId()"
        a
        Json.Decode.string


folderName : Folder -> Task.Task JavaScript.Error String
folderName (Folder a) =
    JavaScript.run
        "a.getName()"
        a
        Json.Decode.string


root : Task.Task JavaScript.Error Folder
root =
    JavaScript.run
        "DriveApp.getRootFolder()"
        Json.Encode.null
        (Json.Decode.map Folder Json.Decode.value)


folders : Folder -> Task.Task JavaScript.Error (List Folder)
folders (Folder a) =
    JavaScript.run
        "(function() { var b = a.getFolders(); var acc = []; while (b.hasNext()) acc.push(b.next()); return acc; })()"
        a
        (Json.Decode.list (Json.Decode.map Folder Json.Decode.value))


folderByName : Folder -> String -> Task.Task JavaScript.Error (Maybe Folder)
folderByName (Folder a) name =
    JavaScript.run
        "(function() { var b = a[0].getFoldersByName(a[1]); return b.hasNext() ? b.next() : null })()"
        (Json.Encode.list identity [ a, Json.Encode.string name ])
        (Json.Decode.nullable (Json.Decode.map Folder Json.Decode.value))


folderByNameOrCreate : Folder -> String -> Task.Task JavaScript.Error Folder
folderByNameOrCreate (Folder a) name =
    JavaScript.run
        "(function() { var b = a[0].getFoldersByName(a[1]); return b.hasNext() ? b.next() : a[0].createFolder(a[1]) })()"
        (Json.Encode.list identity [ a, Json.Encode.string name ])
        (Json.Decode.map Folder Json.Decode.value)


foldersByName : Folder -> String -> Task.Task JavaScript.Error (List Folder)
foldersByName (Folder a) name =
    JavaScript.run
        "(function() { var b = a[0].getFoldersByName(a[1]); var acc = []; while (b.hasNext()) acc.push(b.next()); return acc; })()"
        (Json.Encode.list identity [ a, Json.Encode.string name ])
        (Json.Decode.list (Json.Decode.map Folder Json.Decode.value))


folderOwner : Folder -> Task.Task JavaScript.Error AppScript.User.User
folderOwner (Folder a) =
    JavaScript.run
        "a.getOwner()"
        a
        (Json.Decode.map AppScript.User.User Json.Decode.value)



--


type File
    = File Json.Decode.Value


fileId : File -> Task.Task JavaScript.Error String
fileId (File a) =
    JavaScript.run
        "a.getId()"
        a
        Json.Decode.string


fileName : File -> Task.Task JavaScript.Error String
fileName (File a) =
    JavaScript.run
        "a.getName()"
        a
        Json.Decode.string


files : Folder -> Task.Task JavaScript.Error (List File)
files (Folder a) =
    JavaScript.run
        "(function() { var b = a.getFiles(); var acc = []; while (b.hasNext()) acc.push(b.next()); return acc; })()"
        a
        (Json.Decode.list (Json.Decode.map File Json.Decode.value))


fileByName : Folder -> String -> Task.Task JavaScript.Error (Maybe File)
fileByName (Folder a) name =
    JavaScript.run
        "(function() { var b = a[0].getFilesByName(a[1]); return b.hasNext() ? b.next() : null })()"
        (Json.Encode.list identity [ a, Json.Encode.string name ])
        (Json.Decode.nullable (Json.Decode.map File Json.Decode.value))


filesByName : Folder -> String -> Task.Task JavaScript.Error (List File)
filesByName (Folder a) name =
    JavaScript.run
        "(function() { var b = a[0].getFilesByName(a[1]); var acc = []; while (b.hasNext()) acc.push(b.next()); return acc; })()"
        (Json.Encode.list identity [ a, Json.Encode.string name ])
        (Json.Decode.list (Json.Decode.map File Json.Decode.value))


fileOwner : File -> Task.Task JavaScript.Error AppScript.User.User
fileOwner (File a) =
    JavaScript.run
        "a.getOwner()"
        a
        (Json.Decode.map AppScript.User.User Json.Decode.value)
