defmodule PGS.Area do
    @behaviour Sys.Script.Area

    @impl true
    def onCreate(_args) do
        Sys.Log.debug("Area onCreate - #{Sys.Area.name}")
        print()
    end

    @impl true
    def onStart(_args) do
        Sys.Log.debug("Area onStart - #{Sys.Area.name}")
        print()
    end

    @impl true
    def doPortal("populate", _) do
        Sys.Area.setLocalProperty("foo", "bar")
        Sys.Area.setSharedProperty("beep", "boop")
        Sys.Area.add(0, {2,2}, Sys.Utils.createKey, :element, nil)
        print()
    end

    @impl true
    def doPortal("print", _) do
        print()
    end

    defp print() do
        str = """
        ---- Area Info #{Sys.Area.name} ---->
        player members: #{inspect Sys.Area.members(0, :player)}
        element members: #{inspect Sys.Area.members(0, :element)}
        local properties: #{Area.Data.localPropKeys() |> Enum.map(fn k -> "  #{k}: #{inspect Sys.Area.localProperty(k)}" end) |> Enum.join("\n")}
        shared properties: #{Sys.Area.sharedPropertyKeys() |> Enum.map(fn k -> "  #{k}: #{inspect Sys.Area.sharedProperty(k)}" end) |> Enum.join("\n")}
        <-------------------
        """
        Sys.Log.debug(str)
        str
    end
end
