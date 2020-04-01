defmodule Mates.DevsTest do
  use ExUnit.Case
  alias Mates.Devs

  describe "shuffle_maintaining_pairs" do
    test "with half already assigned" do
      noop_shuffle_fn = & &1

      devs = [
        %{name: "pair2-1", pair: 2, position: nil},
        %{name: "pair2-2", pair: 2, position: nil},
        %{name: "pair1-1", pair: 1, position: nil},
        %{name: "nopair-1", pair: 0, position: nil},
        %{name: "nopair-2", pair: 0, position: nil},
        %{name: "nopair-3", pair: 0, position: nil}
      ]

      expected_output = [
        %{name: "pair1-1", pair: 1, position: 0},
        %{name: "nopair-1", pair: 0, position: 1},
        %{name: "pair2-1", pair: 2, position: 2},
        %{name: "pair2-2", pair: 2, position: 3},
        %{name: "nopair-2", pair: 0, position: 4},
        %{name: "nopair-3", pair: 0, position: 5}
      ]

      assert Devs.shuffle_maintaining_pairs(devs, noop_shuffle_fn) == expected_output
    end

    test "with all already assigned" do
      noop_shuffle_fn = & &1

      devs = [
        %{name: "pair2-1", pair: 2, position: nil},
        %{name: "pair2-2", pair: 2, position: nil},
        %{name: "pair1-1", pair: 1, position: nil},
        %{name: "pair1-2", pair: 1, position: nil},
        %{name: "pair3-1", pair: 3, position: nil},
        %{name: "pair3-2", pair: 3, position: nil}
      ]

      expected_output = [
        %{name: "pair1-1", pair: 1, position: 0},
        %{name: "pair1-2", pair: 1, position: 1},
        %{name: "pair2-1", pair: 2, position: 2},
        %{name: "pair2-2", pair: 2, position: 3},
        %{name: "pair3-1", pair: 3, position: 4},
        %{name: "pair3-2", pair: 3, position: 5}
      ]

      assert Devs.shuffle_maintaining_pairs(devs, noop_shuffle_fn) == expected_output
    end

    test "with none already assigned" do
      noop_shuffle_fn = & &1

      devs = [
        %{name: "nopair-1", pair: 0, position: nil},
        %{name: "nopair-2", pair: 0, position: nil},
        %{name: "nopair-3", pair: 0, position: nil},
        %{name: "nopair-4", pair: 0, position: nil},
        %{name: "nopair-5", pair: 0, position: nil},
        %{name: "nopair-6", pair: 0, position: nil}
      ]

      expected_output = [
        %{name: "nopair-1", pair: 0, position: 0},
        %{name: "nopair-2", pair: 0, position: 1},
        %{name: "nopair-3", pair: 0, position: 2},
        %{name: "nopair-4", pair: 0, position: 3},
        %{name: "nopair-5", pair: 0, position: 4},
        %{name: "nopair-6", pair: 0, position: 5}
      ]

      assert Devs.shuffle_maintaining_pairs(devs, noop_shuffle_fn) == expected_output
    end
  end
end
