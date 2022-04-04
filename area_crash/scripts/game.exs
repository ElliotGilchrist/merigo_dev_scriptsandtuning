defmodule PGS.Game do
    @behaviour Sys.Script.Game

    @area_type "default"

    @impl true
    def doPortal("create_area", %{"name" => name}) do
        PGS.AreaManager.create_area(name)
    end

    def doPortal("cycle_area", %{"name" => name}) do
        Sys.Area.destroy(name)
        PGS.AreaManager.create_area(name)
    end

    def doPortal("cycle_area_repeat", %{"name" => name}) do
        Sys.Batch.run("cycle_area", name)
    end
end


