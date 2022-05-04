defmodule PGS.NifSpammer do
    require Logger

    def rand_layer() do
        0
    end

    @keys [9781119720767564, 9781119717376075, 9781119714459722, 9781119708725321, 9781125845893297]
    def rand_key() do
        Sys.Random.sample(@keys)
    end

    def rand_range() do
        x = Sys.Random.sample(-20..150)
        y = Sys.Random.sample(-20..150)
        w = Sys.Random.sample(-20..150)
        h = Sys.Random.sample(-20..150)
        {x, y, w, h}
    end

    def rand_loc() do
        x = Sys.Random.sample(-20..150)
        y = Sys.Random.sample(-20..150)
        {x, y}
    end

    def calls do
        [
        {:keys, 2, fn handle -> Area.Grid.NifDebug.keys(handle, NifSpammer.rand_layer()) end},
        {:findKeys, 3, fn handle -> Area.Grid.NifDebug.findKeys(handle, NifSpammer.rand_layer(), NifSpammer.rand_range()) end},
        {:locateKey, 3, fn handle -> Area.Grid.NifDebug.locateKey(handle, NifSpammer.rand_layer(), NifSpammer.rand_key()) end},
        {:query, 2, fn handle -> Area.Grid.NifDebug.query(handle, NifSpammer.rand_range()) end},
        {:listeners, 1, fn handle -> Area.Grid.NifDebug.listeners(handle) end},
        {:addListener, 3, fn handle -> Area.Grid.NifDebug.addListener(handle, NifSpammer.rand_key(), NifSpammer.rand_range()) end},
        {:removeListener, 2, fn handle -> Area.Grid.NifDebug.removeListener(handle, NifSpammer.rand_key()) end},
        {:moveListener, 3, fn handle -> Area.Grid.NifDebug.moveListener(handle, NifSpammer.rand_key(), NifSpammer.rand_loc()) end},
        {:addKey, 4, fn handle -> Area.Grid.NifDebug.addKey(handle, NifSpammer.rand_layer(), NifSpammer.rand_key(), NifSpammer.rand_range()) end},
        {:moveKey, 4, fn handle -> Area.Grid.NifDebug.moveKey(handle, NifSpammer.rand_layer(), NifSpammer.rand_key(), NifSpammer.rand_loc()) end},
        {:removeKey, 3, fn handle -> Area.Grid.NifDebug.removeKey(handle, NifSpammer.rand_layer(), NifSpammer.rand_key()) end},
        {:findKeyListeners, 3, fn handle -> Area.Grid.NifDebug.findKeyListeners(handle, NifSpammer.rand_layer(), NifSpammer.rand_key()) end},
        {:export, 1, fn handle -> Area.Grid.NifDebug.export(handle) end},
#        {:import, 2, fn handle ->
#            size = Sys.Random.sample(0..512)
#            data = Enum.reduce(0..(size - 1), <<>>, fn _, acc ->
#                acc <> <<Enum.random(0..255)>>
#            end)
#            Area.Grid.NifDebug.import(handle, data)
#        end},
        {:flush, 1, fn handle -> Area.Grid.NifDebug.flush(handle) end},
        ]
    end

    def spam(count) do
        case spam_new() do
            {:ok, handle} ->
                Enum.each(1..count, fn i ->
                    Logger.info("Nif Spam #{i}/#{count}")
                    {_call, _arity, f} = Sys.Random.sample(calls())
                    f.(handle)
                end)
            e -> Logger.info("Nif Spam failed to create: #{inspect e}")
        end
        Logger.info("Nif Spam Done")
    end

    def mass_spam(batch_count, call_count) do
        Enum.each(1..batch_count, fn i ->
            Logger.info("---------- Nif Mass Spam Batch #{i}/#{batch_count}")
            spam(call_count)
        end)
        Logger.info("Nif Mass Spam Done")
    end

    def spam_new() do
        layers = 1
        multi = Sys.Random.sample(0..1)
        width = :rand.uniform(128)
        height = :rand.uniform(128)
        Area.Grid.NifDebug.new('grid_square', {layers, multi, width, height})
    end
end
