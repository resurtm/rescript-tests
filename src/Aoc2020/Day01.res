open Belt.Array

let goal = 2020

let combinations = (elems): array<('a, 'a)> => {
    elems->reduceWithIndex([], (acc, x, idx) => {
        acc->concat(
            elems
                ->sliceToEnd(idx + 1)
                ->map(y => (x, y))
        )
    })
}

let calcDay01Part01 = input => {
    input
        ->mapWithIndex((i, x) => {
            input->sliceToEnd(i)->map(y => {
                goal == x + y ? Some(x * y) : None
            })
        })
        ->reduce([], (x, a) => a->concat(x))
        ->keepMap(x => x)
        ->get(0)
}

let calcDay01Part01Impl2 = input => {
    input
        ->combinations
        ->reduce([], (acc, (x, y)) => {
            x + y == goal ? acc->concat([x * y]) : acc
        })
        ->get(0)
}

let calcDay01Part02 = input => {
    input
        ->mapWithIndex((i, x) => {
            let out = input->sliceToEnd(i)
            out->mapWithIndex((j, y) => {
                out->sliceToEnd(j)->map(z => {
                    goal == x + y + z ? Some(x * y * z) : None
                })
            })
        })
        ->reduce([], (x, a) => a->concat(x))
        ->reduce([], (x, a) => a->concat(x))
        ->keepMap(x => x)
        ->get(0)
}

let calcDay01Part02Impl2 = input => {
    let result = ref(None)
    input->forEachWithIndex((i, x) => {
        input->sliceToEnd(i)->forEachWithIndex((j, y) => {
            input->sliceToEnd(j)->forEach(z => {
                if x + y + z == goal {
                    result := Some(x * y * z)
                }
            })
        })
    })
    result.contents
}

let data = Tools.readIntsInputData("./input/aoc2020/day01.txt")

Js.log("Day 01, Part 01:")
data
    // ->calcDay01Part01
    ->calcDay01Part01Impl2
    ->Js.log

Js.log("Day 01, Part 02:")
data
    // ->calcDay01Part02
    ->calcDay01Part02Impl2
    ->Js.log
