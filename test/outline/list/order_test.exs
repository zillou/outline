defmodule Outline.List.OrderTest do
  use ExUnit.Case

  import Outline.List.Order

  test "get next pos number" do
    assert pos(nil, nil) == 65_536
    assert pos(65_536, nil) == 131_072
    assert pos(131_072, nil) == 196_608
  end

  test "get prev pos number" do
    assert pos(nil, 65_536) == 32_768
    assert pos(nil, 32_768) == 16_384
    assert pos(nil, 1) == 0.5
  end

  test "get pos between two positions" do
    assert pos(65_536, 131_072) == 98_304
  end
end
