# This just has to add all the rule sets we know about with their canonical names
# We rely on recursive workspaces both to add these rules and to allow
# rules repositories to add their own dependencies.
http_archive(
    name = "io_bazel_rules_go",
    url = "https://codeload.github.com/bazelbuild/rules_go/zip/072a319be76f2c20b10c5c8b6f8cb8f3508f8196",
    strip_prefix = "rules_go-072a319be76f2c20b10c5c8b6f8cb8f3508f8196",
    type = "zip",
)
# The following is only needed until recursive workspaces arrive
load("@io_bazel_rules_go//go:def.bzl", "go_repositories")
go_repositories()