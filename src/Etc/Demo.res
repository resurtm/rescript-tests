open Js.String
open Js.Array

@bs.module("fs") external readFileSync: (string, string) => string = "readFileSync"

("./test.txt")
    ->readFileSync("utf8")
    ->split("\n", _)
    ->filter(line => line != "", _)
    ->map(x => Belt.Option.getWithDefault(
        Belt.Int.fromString(x),
        0
    ), _)
    ->Belt.Array.reduce(0, (x, y) => x + y)
    ->Js.log

type color = Red | Blue | Green
let color = Blue
Js.log(color)

// let myProm = Js.Promise.make((~resolve, ~reject) => resolve(. 2))
// myProm->Js.Promise.then_(value => {
//     Js.log(value)
//     Js.Promise.resolve()
// }, _)

let x = [1, 2]
let x = joinWith(",", x)
let x = split(x, ",")

type result =
  | Success(string)
  | Failure(string, int)

let goodResult = Success("OK!")
let failedResult = Failure(":(", 400)
let result = if Js.Math.random() > 0.5 { goodResult } else { failedResult }

switch result {
| Success(goodMsg) =>
  Js.log("Success! " ++ goodMsg)
| Failure(_, errorCode) =>
  Js.log("Something's wrong. The error code is: " ++ Js.Int.toString(errorCode))
}


/*
let data = readFileSync("./test.txt", "utf8")
let lines = split("\n", data)
let linesWithoutEof = filter(line => line != "", lines)
let nums = map(x => Belt.Option.getWithDefault(Belt.Int.fromString(x), 0), linesWithoutEof)
let sum = Belt.Array.reduce(nums, 0, (x, y) => x + y)

Js.log(sum)
*/
