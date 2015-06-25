defmodule Shape.Ref do
  @moduledoc """
  Uses is_reference to detect if the item is a reference.
  """
  def validate(obj) do
    Kernel.is_reference(obj)
  end

  def desc() do
    "reference"
  end
end
