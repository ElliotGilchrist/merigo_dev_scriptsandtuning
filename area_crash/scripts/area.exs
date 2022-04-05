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

    defp populate() do
        Sys.Area.setLocalProperty("foo", "bar")
        Sys.Area.setSharedProperty("beep", "boop")
        Sys.Area.add(0, {2,2}, Sys.Utils.createKey, :element, nil)
        Sys.Log.info("[PGS.Area #{Sys.Area.name}] Finished populating")
    end
end
