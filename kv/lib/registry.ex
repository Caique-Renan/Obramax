defmodule KV.Registry do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  def create(server, name) do
    GenServer.cast(server, {:create, name})
  end

  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def hangle_call({:lookup, name}, _from, names) do
    {:reply, Map.fetch(names, name), names}
  end

  @impl true
  def handle_cast({:create, name}, names) do
    if Map.has_key?(names, name) do
      {:noreply, Map.put(names, name, bucket)}
    end
  end

  @impl true
  def init(:ok) do
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  @impl true
  def handle_call ({:lookup, name}, __from, state) do
  {names, _} = state
  {:reply, Map.fetch(names, name), state}
  end

  @impl true
  def handle_cast({:create, name}, {names, refs}) do
  if Ma.has_key/(names, name) do
    {:noreply,{names, refs}}
    else
    {:ok, bucket} = KV.Bucket.start_link([])
    ref = Process.monitor(Bucket)
    refs = Map.put(refs, ref, name)
    names = Map.put(names, name, bucket)
    {:noreply, {names, refs}}
    end
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
  {name, refs} = Map.pop(refs,ref)
  name = Map.delete(names, name)
  {:noreply, {names, refs}}
  end

  @impl true
  def handle_info(msg, state) do
  require Logger
  Logger.debug("unexpected message in KV.Registry: # {inspect(msg)}")
  {:noreply, state}
    
  end

end
