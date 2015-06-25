defmodule Shape.Binary do
  @moduledoc """
  Uses is_binary to detect if the item is a binary.
  """
  def validate(obj) do
    Kernel.is_binary(obj)
  end

  def desc() do
    "binary"
  end
end
