defmodule PGS.AreaManager do

    @area_count 1

    def random_area() do
        "myarea#{Sys.Random.integer(@area_count)}"
    end

    def create_area_sync(name) do
        Sys.Log.info("[#{name}] Creating (sync) ->")
        Sys.Area.Grid.Square.create(name, "default", 1, 16, 16, false, :perpetual, :persistent, nil)
        Sys.Log.info("[#{name}] <- Created (sync)")
    end

    def create_area_async(name) do
        Sys.Log.info("[#{name}] Creating (async)")
        Sys.Area.Grid.Square.createAsync(name, "default", 1, 16, 16, false, :perpetual, :persistent, nil)
    end

    def populate_sync(name) do
        Sys.Log.info("[#{name}] Populating (sync) ->")
        try do
            Sys.Area.command(name, "populate", nil)
        rescue
            e ->
                Sys.Log.error("rescued sync populate, #{inspect e}")
        end
        Sys.Log.info("[#{name}] <- Populated (sync)")
    end

    def populate_async(name) do
        Sys.Log.info("[#{name}] Populating (async)")
        Sys.Area.notify(name, "populate", nil)
    end

    def destroy(name) do
        Sys.Log.info("[#{name}] Destroying")
        Sys.Area.destroy(name)
    end

    @actions [:create_area_sync, :create_area_async, :populate_sync, :populate_async, :destroy]

    def random_action(info) do
        name = PGS.AreaManager.random_area()
        info = info <> " " <> name
        try do
            action = Sys.Random.sample(@actions)
            Sys.Log.info(info <> " #{action}")
            apply(__MODULE__, action, [name])
        rescue
            e ->
                Sys.Log.error("Rescued, #{inspect e}")
        end
    end
    :ok
end
