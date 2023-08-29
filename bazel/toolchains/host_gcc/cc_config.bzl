load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "env_entry",
    "env_set",
    "feature",
    "tool_path",
)

all_cpp_compile_actions = [
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.clif_match,
]

all_compile_actions = all_cpp_compile_actions + [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.lto_backend,
]

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    env_features = feature(
        name = "env_path",
        enabled = True,
        env_sets = [
            env_set(
                actions = all_compile_actions + all_link_actions + [ACTION_NAMES.cpp_link_static_library] + [ACTION_NAMES.strip],
                env_entries = [
                    env_entry(
                        key = "HOST_TOOL_PATH",
                        value = "/usr/bin",
                    ),
                ],
            ),
        ],
    )

    tool_paths = [
        tool_path(
            name = "gcc",
            path = "wrappers/gcc",
        ),
        tool_path(
            name = "ld",
            path = "wrappers/ld",
        ),
        tool_path(
            name = "as",
            path = "wrappers/as",
        ),
        tool_path(
            name = "ar",
            path = "wrappers/ar",
        ),
        tool_path(
            name = "cpp",
            path = "/bin/false",
        ),
        tool_path(
            name = "gcov",
            path = "/bin/false",
        ),
        tool_path(
            name = "nm",
            path = "/bin/false",
        ),
        tool_path(
            name = "objdump",
            path = "/bin/false",
        ),
        tool_path(
            name = "strip",
            path = "wrappers/strip",
        ),
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        cxx_builtin_include_directories = [
            "/usr/lib/gcc/x86_64-linux-gnu/9/include",
            "/usr/include",
        ],
        toolchain_identifier = "gcc_host_toolchain",
        host_system_name = "linux",
        target_system_name = "x86_64_linux",
        target_cpu = "x86_64",
        target_libc = "unknown",
        compiler = "gcc",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        features = [env_features],
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)
