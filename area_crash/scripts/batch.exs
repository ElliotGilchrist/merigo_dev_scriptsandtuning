defmodule PGS.Batch do
    @behaviour Sys.Script.Batch

    @batch_count 1
    @action_count 20

    def bulk_test() do
        Enum.each(1..@batch_count, fn i -> Sys.Batch.run("bulk_test", i) end)
    end

    @impl true
    def onRun("bulk_test", batch_index, _id, _status) do
        Sys.Log.info("Starting bulk_test batch #{batch_index}")
        for i <- 1..@action_count do
            PGS.AreaManager.random_action("[Batch #{batch_index} - Action #{i}]")
        end
        Sys.Log.info("Finished bulk_test batch #{batch_index}")
        :ok
    end

end
