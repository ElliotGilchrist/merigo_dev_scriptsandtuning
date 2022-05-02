defmodule PGS.Game do
    @behaviour Sys.Script.Game

    @impl true
    def doPortal("bulk_create", _) do
        PGS.AreaManager.bulk_create()
    end

    def doPortal("bulk_destroy", _) do
        PGS.AreaManager.bulk_destroy()
    end
end


