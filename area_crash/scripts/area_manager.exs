defmodule PGS.AreaManager do
    def create_area(name) do
        case Sys.Area.Grid.Square.create(name, "default", 1, 16, 16, false, :perpetual, :persistent, nil) do
            :ok ->
                Sys.Log.info("Area #{name} created")
                :ok
            :failed ->
                Sys.Log.info("Area #{name} failed to create")
                :failed
        end
    end

    def info() do
        msg = "All areas: #{inspect Sys.Area.all()}"
        Sys.Log.info(msg)
        msg
    end
end
