defmodule PGS.Game do
    @behaviour Sys.Script.Game

    @count 1_000

    @time 30_000 # 30 seconds
    @type "my_type"
    @triggerCount 1

    @impl true
    def doPortal("bulk_create", _) do
        for i <- 1..@count do
            actionId = Sys.Game.scheduleAction(@time, @triggerCount, @type, i)
            Sys.Log.info("Scheduled action #{i}: #{inspect actionId}")
        end
    end

    @impl true
    def onAction(@type, i, jobKey) do
        Sys.Log.info("onAction for #{i}: #{inspect jobKey}")
    end

end

