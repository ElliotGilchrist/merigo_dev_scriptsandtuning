defmodule PGS.Game do
    @behaviour Sys.Script.Game

    @impl true
    def doPortal("bulk_test", _) do
        PGS.Batch.bulk_test()
    end

    def doPortal("foo", _) do
        Sys.Log.info("bar")
        "bar"
    end
end


