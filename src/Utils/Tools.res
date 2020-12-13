@bs.module("fs") external readFileSync: (string, string) => string = "readFileSync"

let readIntsInputData = (fileName) => {
    fileName
        ->readFileSync("utf8")
        ->Js.String.split("\n", _)
        ->Js.Array.filter(line => line != "", _)
        ->Js.Array.map(x => Belt.Option.getWithDefault(
            Belt.Int.fromString(x),
            0
        ), _)
}

let readLinesInputData = (fileName) => {
    fileName
        ->readFileSync("utf8")
        ->Js.String.split("\n", _)
        ->Js.Array.filter(line => line != "", _)
}
