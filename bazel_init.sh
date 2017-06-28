
ORG="ianthehat"
REPO="bazel_rules"
TAG="master"
SHA=$(curl --silent -H "Accept: application/vnd.github.VERSION.sha" https://api.github.com/repos/$ORG/$REPO/commits/$TAG)

echo "Bazel rules from $ORG/$REPO/$TAG at SHA $SHA"

if ! [ -e WORKSPACE ]; then
  echo "Writing workspace"
  cat > WORKSPACE <<- WORKSPACE_END
http_archive(
    name = "$REPO",
    url = "https://codeload.github.com/$ORG/$REPO/zip/$SHA",
    strip_prefix = "$REPO-$SHA",
    type = "zip",
)

WORKSPACE_END
  # The following is only needed until recursive workspaces arrive
  curl --silent https://raw.githubusercontent.com/$ORG/$REPO/$TAG/WORKSPACE >> WORKSPACE
fi

if ! [ -e BUILD.bazel ]; then
  echo "Writing BUILD.bazel"
  curl --silent -o BUILD.bazel https://raw.githubusercontent.com/$ORG/$REPO/$TAG/BUILD.bazel.tpl
fi