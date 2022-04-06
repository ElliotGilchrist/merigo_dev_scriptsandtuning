# Loads these stages when running siab_app.
# I Code.eval_file this file in my `config/user_config.exs` and add it to my `config :game, instances: instances`
[%{
    guid: "85ba25a1-3e35-4ffe-b29d-1649154bd1f0",
    name: "Elliot",
    stages: [
        %{
            suid: "9a0711f3-a7b6-4c79-aa24-39ef42a8d527",
            name: "AreaCrash",
            launch: false,
            script: %{link: "../../../../examples/dev/elliot/area_crash/scripts"},
            tuning: %{link: "../../../../examples/dev/elliot/empty_tuning"},
        },
        %{
            suid: "241947f7-88c8-4008-95ed-1df38e70b29c",
            name: "AreaRecreate",
            launch: false,
            script: %{link: "../../../../examples/dev/elliot/area_recreate/scripts"},
            tuning: %{link: "../../../../examples/dev/elliot/empty_tuning"},
        },
        %{
            suid: "1b5c1d3f-5c2c-43ec-b82f-a70ec3f4e79c",
            name: "GameDeadlock",
            launch: false,
            script: %{link: "../../../../examples/dev/elliot/game_deadlock/scripts"},
            tuning: %{link: "../../../../examples/dev/elliot/empty_tuning"},
        },
    ]
}]
