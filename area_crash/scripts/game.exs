defmodule PGS.Game do
    @behaviour Sys.Script.Game

    @area_type "default"
    @layers 1
    @width 16
    @height 16

    @impl true
    def doPortal("create_area", %{"name" => name}) do
        create_area(name)
    end

    def doPortal("cycle_area", %{"name" => name}) do
        Sys.Area.destroy(name)
        create_area(name)
    end

    def doPortal("cycle_area_repeat", %{"name" => name}) do
        for _ <- 1..500 do
            Sys.Area.destroy(name)
            create_area(name)
            info()
        end
    end

    defp create_area(name) do
        Sys.Area.Grid.Square.create(name, @area_type, @layers, @width, @height, false, :perpetual, :persistent, nil)
    end

    defp info() do
        msg = "All areas: #{inspect Sys.Area.all()}"
        Sys.Log.info(msg)
        msg
    end
end


