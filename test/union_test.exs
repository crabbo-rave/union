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
  def test_res(_), do: {:error, "number less than 10"}

  @spec test_op(number) :: option(String.t)
  def test_op(n) when n in [2, 5, 3], do: :none
  def test_op(n), do: {:some, to_string(n)}
end

defmodule UnionTest do
  use ExUnit.Case
  doctest Union

  test "option" do
    assert Test.test_op(5) == :none
    assert Test.test_op(6) == {:some, "6"}
  end

  test "result" do
    assert Test.test_res(11) == {:ok, 11}
    assert Test.test_op(5)
  end
end
