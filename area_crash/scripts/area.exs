defmodule PGS.Area do
    @behaviour Sys.Script.Area

    @impl true
    def doCommand("populate", _) do
        populate()
    end

    @impl true
    def onNotify("populate", _) do
        populate()
    end

    defp populate() do
        Sys.Area.setLocalProperty("foo", "bar")
        Sys.Area.setSharedProperty("beep", "boop")
        Sys.Area.add(0, {2,2}, Sys.Utils.createKey, :element, nil)
    end
end
