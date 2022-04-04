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

    def info() do
        msg = "All areas: #{inspect Sys.Area.all()}"
        Sys.Log.info(msg)
        msg
    end

    def random_action(name) do
        case Sys.Random.integer(5) do
            0 -> create_area_async(name)
            1 -> create_area_sync(name)
            2 -> Sys.Area.destroy(name)
            3 -> Sys.Area.command(name, "populate", nil)
            4 -> Sys.Area.notify(name, "populate", nil)
        end
    end

    def populate(name) do
        Sys.Area.setLocalProperty("foo", "bar")
        Sys.Area.setSharedProperty("beep", "boop")
        Sys.Area.add(0, {2,2}, Sys.Utils.createKey, :element, nil)
    end
end
