defmodule PGS.Game do
    @behaviour Sys.Script.Game

    @count 10_000

    @time 30_000 # 30 seconds
    @actionType "my_type"
    @triggerCount -1

    @impl true
    def doPortal("bulk_schedule", _) do
        Sys.Log.info("Bulk scheduling #{@count} actions")
        for i <- 1..@count do
            actionId = Sys.Game.scheduleAction(@time, @triggerCount, @actionType, i)
            Sys.Log.info("Scheduled action #{i}: #{inspect actionId}")
        end
    end

    @impl true
    def onAction(@actionType, _i, _jobKey) do
        # Sys.Log.info("onAction for #{i}: #{inspect jobKey}")3
        :ok
    end

end


