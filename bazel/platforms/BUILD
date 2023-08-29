constraint_setting(name = "target")

constraint_setting(name = "compiler")

constraint_value(
    name = "host",
    constraint_setting = ":target",
)

constraint_value(
    name = "gcc",
    constraint_setting = ":compiler",
)

platform(
    name = "host_gcc",
    constraint_values = [
        ":host",
        ":gcc",
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
)
