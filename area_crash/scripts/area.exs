defmodule PGS.Area do
    @behaviour Sys.Script.Area

    @impl true
    def profile(_) do
        %{name: Sys.Area.name}
    end

    @impl true
    def onCreate(_args) do
        Sys.Log.info("[PGS.Area #{Sys.Area.name}] onCreate")
    end

    @impl true
    def onDestroy(_args) do
        Sys.Log.info("[PGS.Area #{Sys.Area.name}] onDestroy")
    end

    @impl true
    def onStart(_args) do
        Sys.Log.info("[PGS.Area #{Sys.Area.name}] onStart")
    end

    @impl true
    def onStop(_args) do
        Sys.Log.info("[PGS.Area #{Sys.Area.name}] onStop")
    end

    @impl true
    def doCommand("populate", _) do
        Sys.Log.info("[PGS.Area #{Sys.Area.name}] Populating (sync)")
        populate()
    end

    @impl true
    def onNotify("populate", _) do
        Sys.Log.info("[PGS.Area #{Sys.Area.name}] Populating (async)")
        populate()
    end

    @entity_data Enum.map(1..1000, fn i -> "#{i}" end)

    defp populate() do
        Sys.Area.setLocalProperty("foo", %{"foo" => @entity_data})
        Sys.Area.setSharedProperty("beep", "boop")
        for _ <- 1..10 do
            Sys.Area.add(Sys.Random.sample(0..(Sys.Area.layers - 1)), {Sys.Random.sample(0..8), Sys.Random.sample(0..8)}, Sys.Utils.createKey, :element, @entity_data)
        end

        Sys.Area.add(0, {2,2}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {2,3}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {2,4}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {1,4}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {1,8}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {2,8}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {8,3}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {8,4}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {8,8}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Log.info("[PGS.Area #{Sys.Area.name}] Finished populating")
    end
end
