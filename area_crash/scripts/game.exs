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
            rsp = create_area(name)
            inf = info()
            {rsp, inf}
        end
    end

    defp create_area(name) do
        case Sys.Area.Grid.Square.create(name, @area_type, @layers, @width, @height, false, :perpetual, :persistent, nil) do
            :ok ->
                Sys.Log.info("Area #{name} created")
                :ok
            :failed ->
                Sys.Log.info("Area #{name} failed to create")
                :failed
        end
    end

    defp info() do
        msg = "All areas: #{inspect Sys.Area.all()}"
        Sys.Log.info(msg)
        msg
    end
end


