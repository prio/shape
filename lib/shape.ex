defmodule Shape do

  defp merge_errors(coll) do
    errors = Enum.map(coll, fn x ->
      case x do
        :ok ->
          nil
        {:error, error} ->
          error
      end
    end) |>
    Enum.filter(fn x -> not(is_nil(x)) end)
    case Enum.count(errors) do
      0 ->
        :ok
      _ ->
        {:error, errors}
    end

  end

  def validate(shape, obj) when is_list(shape) do
    errors = Enum.zip(shape, obj) |>
    Enum.map(fn {s, o} -> validate(s, o) end) |>
    merge_errors
  end

  def validate(shape, obj) when is_map(shape) do
    merge_errors([validate(Dict.keys(shape), Dict.keys(obj)),
                  validate(Dict.values(shape), Dict.values(obj))])
  end

  def validate(shape, obj) do
    if shape.validate(obj) do
      :ok
    else
      {:error, "#{obj} is not a #{shape.desc}"}
    end
  end
end
