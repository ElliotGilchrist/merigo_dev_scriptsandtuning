defmodule PGS.Game do
    @behaviour Sys.Script.Game

    @impl true
    def doPortal("bulk_test", _) do
        PGS.Batch.bulk_test()
    end

    def doPortal("create_async", %{"name" => name}) do
        PGS.AreaManager.create_area_async(name)
    end

    def doPortal("create_sync", %{"name" => name}) do
        PGS.AreaManager.create_area_sync(name)
    end

    def doPortal("destroy", %{"name" => name}) do
        Sys.Area.destroy(name)
    end

    def doPortal("populate_async", %{"name" => name}) do
        Sys.Area.notify(name, "populate", nil)
    end

    def doPortal("populate_sync", %{"name" => name}) do
        Sys.Area.command(name, "populate", nil)
    end
end


