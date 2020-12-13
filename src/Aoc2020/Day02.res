open Belt.Array

type item = {
    min: int,
    max: int,
    letter: string,
    data: string
}

let fromString = (str: option<string>): int => {
    str
        ->Belt.Option.getWithDefault("0")
        ->Belt.Int.fromString
        ->Belt.Option.getWithDefault(0)
}

let parseData = (lines): array<item> => {
    let regExp = %re("/^(\d+)-(\d+) ([a-z]{1}): ([a-z]+)$/")
    lines->reduce([]: array<item>, (acc, line) => {
        switch regExp->Js.Re.exec_(line) {
            | None => acc
            | Some(result) => {
                let caps = result
                    ->Js.Re.captures
                    ->map(x => x->Js.Nullable.toOption)
                let item = {
                    min: fromString(caps[1]),
                    max: fromString(caps[2]),
                    letter: Belt.Option.getWithDefault(caps[3], ""),
                    data: Belt.Option.getWithDefault(caps[4], ""),
                }
                acc->concat([item])
        }}
    })
}

let checkPasswords = (passwords: array<item>) => {
    passwords
        ->map(password => {
            let freqs = Belt.HashMap.String.make(~hintSize=10);
            password.data
                ->Js.String.split("", _)
                ->forEach(letter => {
                    let value = switch Belt.HashMap.String.get(freqs, letter) {
                        | None => 1
                        | Some(value) => value + 1
                    }
                    Belt.HashMap.String.set(freqs, letter, value)
                })

            let value = switch Belt.HashMap.String.get(freqs, password.letter) {
                | None => -1
                | Some(value) => value
            }
            password.min <= value && value <= password.max
        })
        ->keep(x => x)
        ->length
}

("Day 02, Part 01:")->Js.log
("./input/aoc2020/day02.txt")
    ->Tools.readLinesInputData
    ->parseData
    ->checkPasswords
    ->Js.log
