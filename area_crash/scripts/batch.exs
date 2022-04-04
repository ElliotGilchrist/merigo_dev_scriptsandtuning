defmodule PGS.Batch do
    @behaviour Sys.Script.Batch

    @impl true
    def onRun("cycle_areas", _args, _id, _status) do
        Sys.Log.info("Starting cycle_areas batch process")
        results = for _ <- 1..500 do
            Sys.Area.destroy(name)
            before_info = PGS.AreaManager.info()
            create_rsp = PGS.AreaManager.create_area(name)
            after_info = PGS.AreaManager.info()
            {before_info, create_rsp, after_info}
        end
        Sys.Log.info(inspect results)
        results
    end
end
