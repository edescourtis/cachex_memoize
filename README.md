# CachexMemoize

  CachexMemoize provides straightforward memoization macros using Cachex as a backend.

  ## How to memoize

  If you want to cache a function, `use CachexMemoize` on the module and change `def` to `defmemo` and specify a cache.
  IMPORTANT! If your cache is not started the function will run directly without Cachex. If this behaviour is not desirable You can provide a `fail` parameter.

  for example:

  ```elixir
  defmodule Example do
    def f(x) do
      Process.sleep(1000)
      make_ref()
    end
  end
  ```

  this code changes to:

  ```elixir
  Cachex.start(:mycache) # Normally you would `start_link` Cachex in a supervisor.

  defmodule Example do
    use CachexMemoize
    defmemo f(x), cache: :mycache do
      Process.sleep(1000)
      make_ref()
    end
  end
  ```

  If a function defined by `defmemo` raises an error, the result is not cached and one of waiting processes will call the function.

  ## Exclusive

  A caching function that is defined by `defmemo` is never called in parallel.

  ```elixir
  Cachex.start(:mycache)
  defmodule Calc do
  use Memoize
      defmemo calc(), cache: :mycache do
        Process.sleep(1000)
        IO.puts "called!"
      end
  end

  # call `Calc.calc/0` in parallel using many processes.
  for _ <- 1..10000 do
    Process.spawn(fn -> Calc.calc() end, [])
  end

  # but, actually `Calc.calc/0` is called only once.
  ```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cachex_memoize` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cachex_memoize, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/cachex_memoize](https://hexdocs.pm/cachex_memoize).

