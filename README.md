# Union

Example:

```elixir
defmodule Test do
  import Union

  union result(v, e) do
      ok v
      error e
  end

  union option(t) do
      none
      some t
  end

  @spec test_res(number) :: result(number, String.t)
  def test_res(n) when n > 10, do: {:ok, n}
  def test_res(n), do: {:error, "number less than 10"}

  @spec test_op(number) :: option(String.t)
  def test_op(n) when n in [2, 5, 3], do: :none
  def test_op(n), do: {:some, to_string(n)}
end
```