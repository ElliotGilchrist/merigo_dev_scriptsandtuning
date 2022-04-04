defmodule PGS.Batch do
    @behaviour Sys.Script.Batch

    def bulk_test() do
        Enum.each(1..20, fn _ -> Sys.Batch.run("cycle_area") end)
    end

    @impl true
    def onRun("cycle_area", _args, _id, _status) do
        for _ <- 1..500 do
            name = PGS.AreaManager.random_area()
            PGS.AreaManager.random_action(name)
        end
        :ok
    end


end
