defmodule Shape.Bool do
  @moduledoc """
  Uses is_boolean to detect if the item is a boolean.
  """
  def validate(obj) do
    Kernel.is_boolean(obj)
  end

  def desc() do
    "boolean"
  end
end
