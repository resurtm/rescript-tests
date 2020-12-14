open Belt.Array

let opWithFn = (x: 'a, y: 'a, fn: ('a, 'a) => 'a): 'a => {
    10 + fn(x, y)
}

Js.log(opWithFn(2, 5, (a, b) => a + b))

[1, 2, 3]
    ->map(x => x * x)
    ->Js.log

// let myList = list{1, 2, 3}
// let list{head, ...tail} = myList

// let rec iterList = (list{head, ...tail}) => {
//     tail == list{} ? head : head + iterList(tail)
// }

// list{10, 25, 55}
//     ->iterList
//     ->Js.log
