load("@io_bazel_rules_go//go:def.bzl", "gazelle", "go_prefix")
 
# Go specific top level rules.
gazelle(name="go_update")
# we should be able to kill go_prefix in the future
go_prefix("bad_name")

