defmodule MatesWeb.PageView do
  use MatesWeb, :view

  def headshot_position_id(%{position: nil}), do: ""
  def headshot_position_id(%{position: position}), do: "position-#{position}"
end
