defmodule PGS.AreaManager do

    @area_count 10_000

    def area_name(index) do
        "bulkarea#{index}"
    end

    def bulk_create() do
        Enum.each(1..@area_count, fn i ->
            area = area_name(i)
            create_area(area)
        end)
    end

    def bulk_destroy() do
        Enum.each(1..@area_count, fn i ->
            area = area_name(i)
            destroy(area)
        end)
    end

    def create_area(name) do
        Sys.Log.info("[#{name}] Creating")
        Sys.Area.Grid.Square.createElixirBacked(name, {7, 7}, nil)
    end

    def area_pid(name) do
        Area.Controller.service(Sys.Game.key, name)
    end

    def destroy(name) do
        pid = area_pid(name)
        Sys.Log.info("[#{name}] Destroying pid: #{inspect pid}")
        if (pid != :invalid_area) do
            Sys.Area.destroy(name)
        end
        # GenServer.cast(pid, {:destroy, gKey, areaName, args})
    end

end
