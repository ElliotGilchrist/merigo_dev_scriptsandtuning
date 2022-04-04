defmodule PGS.AreaManager do

    @area_count 100

    def random_area() do
        "myarea#{Sys.Random.integer(@area_count)}"
    end

    def create_area_sync(name) do
        Sys.Log.info("Creating #{name} sync")
        Sys.Area.Grid.Square.create(name, "default", 1, 16, 16, false, :perpetual, :persistent, nil)
    end

    def create_area_async(name) do
        Sys.Log.info("Creating #{name} async")
        Sys.Area.Grid.Square.createAsync(name, "default", 1, 16, 16, false, :perpetual, :persistent, nil)
    end

    def random_action(name) do
        try do
            case Sys.Random.integer(5) do
                0 -> create_area_async(name)
                1 -> create_area_sync(name)
                2 ->
                    Sys.Log.info("Destroying #{name}")
                    Sys.Area.destroy(name)
                3 ->
                    Sys.Log.info("Populating (sync) #{name}")
                    Sys.Area.command(name, "populate", nil)
                4 ->
                    Sys.Log.info("Populating (async) #{name}")
                    Sys.Area.notify(name, "populate", nil)
            end
        rescue
            e ->
                Sys.Log.info("Rescued, #{inspect e}")
        end
    end
    :ok
end
