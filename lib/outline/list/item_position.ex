defmodule Outline.List.ItemPosition do
  def pos(prev, next)
  def pos(nil, next), do: pos(0, next)
  def pos(prev, nil), do: prev + 65536
  def pos(prev, next), do: (prev + next) / 2
end
