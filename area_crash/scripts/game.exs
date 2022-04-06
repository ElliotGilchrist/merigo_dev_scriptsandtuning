defmodule PGS.Game do
    @behaviour Sys.Script.Game

    @impl true
    def doPortal("bulk_test", _) do
        PGS.Batch.bulk_test()
    end

    def doPortal("bulk_create", _) do
        PGS.AreaManager.bulk_create()
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

    def doPortal("exec", %{"exec" => exec}) do
        {result, errors} = Code.eval_string(exec, [], __ENV__)
        Sys.Log.debug(inspect result)
        if (errors != []) do
            Sys.Log.error("Portal Exec Error: #{inspect errors}")
        end
        result
    end
end


