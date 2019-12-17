# LineReader

Line reader is a small elixir app that allows you to return the specified line from a large file

## Testing the app

Run

```iex -S mix```

In iex, type

```Line.Reader.get_line("./lib/test.txt", LINE_NUMBER)```

## Measure Performance

```Benchwarmer.benchmark [&LineReader.get_line/1, &LineReader.get_line2/1], LINE_NUMBER```

