defmodule MUD.Script do
  use GenServer
  use Export.Ruby

  def start_link(path), do: GenServer.start_link(__MODULE__, path, name: __MODULE__)

  def init(path), do: Ruby.start_link(ruby_lib: Path.expand(path)) |> setup
  def setup({:ok, ruby}), do: ruby |> Ruby.call("main", "MUD::create", [self(), ruby])

  def handle_call({:input, state, action}, from, ruby) do
    ruby |> :ruby.cast({action, state, from})
    {:noreply, ruby}
  end

  def handle_info({:error, reason, from}, ruby) do
    GenServer.reply(from, {:error, reason})
    {:noreply, ruby}
  end

  def handle_info({action, message, from}, ruby) do
    GenServer.reply(from, {action, message})
    {:noreply, ruby}
  end

  def input(state, action), do: GenServer.call(__MODULE__, {:input, state, action})
end
