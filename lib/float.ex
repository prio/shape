defmodule Shape.Float do
  @moduledoc """
  Uses is_float to detect if the item is a float.
  """
  def validate(obj) do
    Kernel.is_float(obj)
  end

  def desc() do
    "float"
  end
end
