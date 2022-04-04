defmodule PGS.AreaManager do

    @area_count 100

    def random_area() do
        "myarea#{Sys.Random.integer(@area_count)}"
    end

    def create_area_sync(name) do
        Sys.Area.Grid.Square.create(name, "default", 1, 16, 16, false, :perpetual, :persistent, nil)
    end

    def create_area_async(name) do
        Sys.Area.Grid.Square.createAsync(name, "default", 1, 16, 16, false, :perpetual, :persistent, nil)
    end

    def random_action(info) do
        name = PGS.AreaManager.random_area()
        info = info <> " " <> name
        try do
            case Sys.Random.integer(5) do
                0 ->
                    Sys.Log.info("#{info} Creating (async)")
                    create_area_async(name)
                1 ->
                    Sys.Log.info("#{info} Creating (sync)")
                    create_area_sync(name)
                2 ->
                    Sys.Log.info("#{info} Destroying")
                    Sys.Area.destroy(name)
                3 ->
                    Sys.Log.info("#{info} Populating (sync)")
                    Sys.Area.command(name, "populate", nil)
                4 ->
                    Sys.Log.info("#{info} Populating (async)")
                    Sys.Area.notify(name, "populate", nil)
            end
        rescue
            e ->
                Sys.Log.info("Rescued, #{inspect e}")
        end
    end
    :ok
end
