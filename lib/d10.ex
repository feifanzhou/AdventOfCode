defmodule AOC.D10 do
  def part_one do
    {diff_1, diff_3} = parse_input() |> joltage_chain() |> joltage_differences()
    diff_1 * diff_3
  end

  defp joltage_differences(sorted_chain) do
    {differences, _} = Enum.reduce(sorted_chain, {{0, 0}, 0}, fn adapter, {{diff_1, diff_3}, prev} ->
      case adapter - prev do
        1 -> {{diff_1 + 1, diff_3}, adapter}
        2 -> {{diff_1, diff_3}, adapter}
        3 -> {{diff_1, diff_3 + 1}, adapter}
        x -> raise "Difference between adapters is #{x}, which seems to be too big."
      end
    end)
    differences
  end

  defp joltage_chain(adapters) do
    # Sort descending first
    [largest | rest] = Enum.sort(adapters, :desc)

    rest
    |> List.insert_at(0, largest)
    # built-in adapter
    |> List.insert_at(0, largest + 3)
    # Fix order
    |> Enum.reverse()
  end

  def part_two do
    # https://www.reddit.com/r/adventofcode/comments/kabi91/2020_day_10_closedform_mathematical_solution/
    # Too much math 😬
  end

  @input """
  160
  34
  123
  159
  148
  93
  165
  56
  179
  103
  171
  44
  110
  170
  147
  98
  25
  37
  137
  71
  5
  6
  121
  28
  19
  134
  18
  7
  66
  90
  88
  181
  89
  41
  156
  46
  8
  61
  124
  9
  161
  72
  13
  172
  111
  59
  105
  51
  109
  27
  152
  117
  52
  68
  95
  164
  116
  75
  78
  180
  81
  47
  104
  12
  133
  175
  16
  149
  135
  99
  112
  38
  67
  53
  153
  2
  136
  113
  17
  145
  106
  31
  45
  169
  146
  168
  26
  36
  118
  62
  65
  142
  130
  1
  140
  84
  94
  141
  122
  22
  48
  102
  60
  178
  127
  73
  74
  87
  182
  35
  """

  defp parse_input do
    @input |> String.trim() |> String.split("\n") |> Enum.map(&String.to_integer/1)
  end
end
