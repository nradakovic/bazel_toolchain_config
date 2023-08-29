load(":cc_config.bzl", "cc_toolchain_config")

filegroup(name = "empty")

filegroup(
    name = "compiler_files",
    srcs = [
        "wrappers/binwrapper",
        "wrappers/gcc",
    ],
)

filegroup(
    name = "linker_files",
    srcs = [
        "wrappers/binwrapper",
        "wrappers/gcc",
        "wrappers/ld",
    ],
)

filegroup(
    name = "ar_files",
    srcs = [
        "wrappers/ar",
        "wrappers/binwrapper",
    ],
)

filegroup(
    name = "as_files",
    srcs = [
        "wrappers/as",
        "wrappers/binwrapper",
    ],
)

filegroup(
    name = "strip_files",
    srcs = [
        "wrappers/binwrapper",
        "wrappers/strip",
    ],
)

filegroup(
    name = "all_files",
    srcs = [
        ":ar_files",
        ":as_files",
        ":compiler_files",
        ":linker_files",
        ":strip_files",
    ],
)

cc_toolchain_config(name = "cc_tc_host_gcc")

cc_toolchain(
    name = "cc_host_gcc",
    all_files = ":all_files",
    ar_files = ":ar_files",
    as_files = ":as_files",
    compiler_files = ":compiler_files",
    dwp_files = ":empty",
    linker_files = ":linker_files",
    objcopy_files = ":empty",
    strip_files = ":strip_files",
    supports_param_files = 1,
    toolchain_config = ":cc_tc_host_gcc",
    toolchain_identifier = "gcc_host_toolchain",
)

toolchain(
    name = "host_gcc",
    exec_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    target_compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
    toolchain = ":cc_host_gcc",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)
