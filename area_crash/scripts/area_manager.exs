defmodule PGS.AreaManager do

    @area_count 10

    def random_area() do
        random_area(Sys.Random.integer(@area_count))
    end

    def random_area(index) do
        "resizing2#{index}"
    end

    def bulk_create() do
        Enum.each(1..@area_count, fn i ->
            area = random_area(i)
            create_area(area)
        end)
    end

    def create_area(name) do
        Sys.Log.info("[#{name}] Creating")
        Sys.Area.Grid.Square.startElixirBacked(name, {Sys.Random.sample(1..3), Sys.Random.sample(1..8)}, nil, layers: Sys.Random.sample(1..8), multi: true)
    end

    def populate_sync(name) do
        Sys.Log.info("[#{name}] Populating (sync) ->")
        try do
            Sys.Area.command(name, "populate", nil)
        rescue
            e ->
                Sys.Log.error("rescued sync populate, #{inspect e}")
        catch
            :exit, e -> Sys.Log.error("caught exit sync pop, #{inspect e}")
            e ->
                Sys.Log.error("caught sync populate, #{inspect e}")
        end
        Sys.Log.info("[#{name}] <- Populated (sync)")
    end

    def populate_async(name) do
        Sys.Log.info("[#{name}] Populating (async)")
        Sys.Area.notify(name, "populate", nil)
    end

    def area_pid(name) do
        Area.Controller.service(Sys.Game.key, name)
    end

    def destroy(name) do
        pid = area_pid(name)
        Sys.Log.info("[#{name}] Destroying pid: #{inspect pid}")
        Sys.Area.destroy(name)
        # GenServer.cast(pid, {:destroy, gKey, areaName, args})
    end

    @actions [:create_area, :populate_sync, :populate_async, :destroy]
    # @actions [:create_area_sync]

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
