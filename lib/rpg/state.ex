defmodule RPG.State do
  use GenServer

  def start_link(state \\ %{chapter: 1, dialog: 0}) do
    GenServer.start_link(__MODULE__, state)
  end

  def init(state), do: {:ok, state}

  def handle_cast({:next, amount}, state), do: {:noreply, state |> Map.update(:dialog, 0, &(&1 + amount))}
  def handle_cast({:jump, index}, state), do: {:noreply, state |> Map.put(:dialog, index)}

  def handle_call(:get, _from, state),do: {:reply, state, state}

  def next(pid, amount \\ 1), do: GenServer.cast(pid, {:next, amount})
  def get(pid), do: GenServer.call(pid, :get)
  def jump(pid, index \\ 0), do: GenServer.cast(pid, {:jump, index})
end
