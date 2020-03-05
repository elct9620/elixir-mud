defmodule MUD.Reaction do
  use GenServer

  def start_link(reactions \\ []), do: GenServer.start_link(__MODULE__, reactions)
  def init(reactions), do: {:ok, reactions}

  def handle_call(:next, _from, [reaction | reactions]), do: {:reply, reaction, reactions}
  def handle_call(:next, _from, []), do: {:reply, nil, []}
  def handle_info(reaction, reactions), do: {:noreply, reactions ++ [reaction]}

  def next(pid), do: GenServer.call(pid, :next)
end
