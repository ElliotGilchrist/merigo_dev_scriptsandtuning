defmodule PGS.Area do
    @behaviour Sys.Script.Area

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
        Sys.Area.add(0, {1,2}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {2,2}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {2,3}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {2,4}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Area.add(0, {1,4}, Sys.Utils.createKey, :element, @entity_data)
        Sys.Log.info("[PGS.Area #{Sys.Area.name}] Finished populating")
    end
end
