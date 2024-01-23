defmodule War do
  @moduledoc """
    Documentation for `War`.
  """

  @doc """
    Function stub for deal/1 is given below. Feel free to add
    as many additional helper functions as you want.

    The tests for the deal function can be found in test/war_test.exs.
    You can add your five test cases to this file.

    Run the tester by executing 'mix test' from the war directory
    (the one containing mix.exs)
  """

  def deal(shuf) do
    p1 = Enum.reverse(elem(split(shuf),0))
    p2 = Enum.reverse(elem(split(shuf),1))
    #IO.inspect(p1)
    #IO.inspect(p2)
    holder = fight(p1, p2)
    winner = for {v, i} <- Enum.with_index(holder), do: replaceAces(v)
    #IO.puts("FIGHTTT")
    #IO.inspect(holder)
    # IO.puts("winner")
    # IO.inspect(winner)
    winner
  end

  def split(deck) do
    p1 = for {v, i} <- Enum.with_index(deck), rem(i, 2) == 0, do: replaceOnes(v)
    p2 = for {v, i} <- Enum.with_index(deck), rem(i, 2) == 1, do: replaceOnes(v)
    {p1, p2}
  end

  def replaceOnes(value) do
    if value == 1, do: 14, else: value
  end

  def replaceAces(value) do
    if value == 14, do: 1, else: value
  end
  def fight(startp1, startp2), do: fight(startp1, startp2, [])

  def fight(startp1, startp2, tie) do
    if length(startp1) == 0 or length(startp2) == 0 do
      if length(startp1) == 0 do
        # IO.puts("p2 wins")
        #IO.inspect(startp2 ++  Enum.sort(tie, fn a, b -> a > b end))
        winner = startp2 ++  Enum.sort(tie, fn a, b -> a > b end)
        #IO.puts("look")
        #IO.inspect(winner)
        winner
      else
        # IO.puts("p1 wins")
        #IO.inspect(startp1 ++  Enum.sort(tie, fn a, b -> a > b end))
        winner = startp1 ++  Enum.sort(tie, fn a, b -> a > b end)
        winner
      end
    else
      # IO.puts("---------------------------")
      # IO.puts("fighting")
      # IO.inspect(startp1)
      # IO.inspect(startp2)
      # IO.inspect(tie)
      [h1|t1] = startp1
      [h2|t2] = startp2
      if h1 > h2 do
        fight((t1 ++ Enum.sort((tie ++ [h1,h2]), fn a, b -> a > b end)),t2, [])
      else
        if h2 > h1 do
          fight(t1, (t2 ++ Enum.sort((tie ++ [h2,h1]), fn a, b -> a > b end)), [])
        else
          if(length(startp1) == 2) do
            [h2,w2|t2] = startp2
            fight([], t2, tie ++ [h2,w2] ++ startp1)
          else
            if(length(startp2) == 2) do
              [h1,w1|t1] = startp1
              fight(t1, [], tie ++ [h1,w1] ++ startp2)
            else
              if(length(startp1) == 1) do
                fight([],t2, tie ++ [h2] ++ startp1)
              else
                if(length(startp2) == 1) do
                  fight(t1,[], tie ++ [h1] ++ startp2)
                else
                  [h1,w1|t1] = startp1
                  [h2,w2|t2] = startp2
                  fight(t1, t2, tie ++ [h1,h2,w1,w2])
                end
              end
            end
          end


        end
      end
    end
  end
end
