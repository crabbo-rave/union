defmodule Union do
  defmacro union(type_name, do: ast) do
    fields_ast =
        case ast do
          {:__block__, [], fields} -> fields
          field -> [field]
        end
    fields = Enum.map(fields_ast, fn
        {field, _, nil} -> field
        {field, _, items} -> {:{}, [], [field | items]}
    end)
    unioned = Enum.reduce(fields, &{:|, [], [&1, &2]})
    quote location: :keep do
        @type unquote(type_name) :: unquote(unioned)
    end
  end
end
