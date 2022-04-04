defmodule PGS.Batch do
    @behaviour Sys.Script.Batch

    def bulk_test() do
        Enum.each(1..20, fn _ -> Sys.Batch.run("bulk_test") end)
    end

    @impl true
    def onRun("bulk_test", _args, _id, _status) do
        Sys.Log.debug("Starting bulk_test batch")
        for _ <- 1..500 do
            name = PGS.AreaManager.random_area()
            PGS.AreaManager.random_action(name)
        end
        Sys.Log.debug("Finished bulk_test batch")
        :ok
    end


end
