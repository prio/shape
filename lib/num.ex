defmodule Shape.Num do
  @moduledoc """
  Uses is_number to detect if the item is a number.
  """
  def validate(obj) do
    Kernel.is_number(obj)
  end

  def desc() do
    "number"
  end
end
