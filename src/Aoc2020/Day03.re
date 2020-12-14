let parseData = (lines: array(string)): array(array(char)) => {
    lines
    |> Array.map(line => {
        Js.String.split("", line)
        |> Array.map(x => x.[0])
    });
};

let calculate = (grid: array(array(char))) => {
    let height = Array.length(grid)
    let width = Array.length(grid[0]);

    let seq = Belt.Array.makeBy(height, (i) => i);
    Belt.Array.reduce(seq, 0, (acc, j) => {
        let iT = j * 3
        let i = iT mod width
        grid[j][i] == '#' ? acc + 1 : acc
    });
};

Js.log("Day 03, Part 01:");
"./input/aoc2020/day03.txt"
|> Tools.readLinesInputData
|> parseData
|> calculate
|> Js.log;
