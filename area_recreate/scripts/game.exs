defmodule PGS.Game do
    @behaviour Sys.Script.Game

    @area_type "default"
    @layers 1
    @width 16
    @height 16

    @impl true
    def doPortal("create_area", %{"name" => name}) do
        Sys.Area.Grid.Square.create(name, @area_type, @layers, @width, @height, false, :perpetual, :persistent, nil)
    end
end


