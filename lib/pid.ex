defmodule Shape.Pid do
  @moduledoc """
  Uses is_pid to detect if the item is a pid.
  """
  def validate(obj) do
    Kernel.is_pid(obj)
  end

  def desc() do
    "pid"
  end
end
