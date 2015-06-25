defmodule Shape.Port do
  @moduledoc """
  Uses is_port to detect if the item is a port.
  """
  def validate(obj) do
    Kernel.is_port(obj)
  end

  def desc() do
    "port"
  end
end
