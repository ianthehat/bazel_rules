# Automatic rules for [Bazel](https://bazel.build/)

This is an exploratory project to see what a repository to coordinate independant sets of bazel rules would look like

Use
```
bash <(curl --silent https://raw.githubusercontent.com/ianthehat/bazel_rules/master/bazel_init.sh)
```
to initialise a directory with a basic WORKSPACE and BUILD.bazel


Things are still ugly, here are the steps to build [hugo](https://github.com/gohugoio/hugo) as an example.


```
git clone git@github.com:gohugoio/hugo.git
cd hugo

# Now we generate a basic workspace
bash <(curl --silent https://raw.githubusercontent.com/ianthehat/bazel_rules/master/bazel_init.sh)

#An ugly step, we have to hand edit the go_prefix at this point....

# Now we run gazelle to generate all the build files
bazel run //:go_update

# And now the very very ugly step where you have to hand add all the dependancies
# Doing this normally involves trying to build, copying the string out of the error message, and running wtool
# You only get one dependancy each time you do this, I have listed them all here for now
bazel build @io_bazel_rules_go//go/tools/wtool
./bazel-bin/external/io_bazel_rules_go/go/tools/wtool/wtool \
  com_github_spf13_viper \
  com_github_mitchellh_mapstructure \
  com_github_stretchr_testify \
  com_github_spf13_afero \
  com_github_chaseadamsio_goorgeous \
  com_github_BurntSushi_toml \
  com_github_bep_gitmap \
  com_github_mitchellh_mapstructure \
  com_github_kyokomi_emoji \
  com_github_spf13_pflag \
  com_github_russross_blackfriday \
  com_github_spf13_jwalterweatherman \
  com_github_miekg_mmark \
  com_github_fortytw2_leaktest \
  com_github_dchest_cssmin \
  com_github_spf13_cast \
  org_golang_x_image \
  com_github_eknkc_amber \
  com_github_fsnotify_fsnotify \
  com_github_hashicorp_go_immutable_radix \
  com_github_bep_inflect \
  com_github_nicksnyder_go_i18n \
  org_golang_x_text \
  com_github_gorilla_websocket \
  com_github_spf13_nitro \
  com_github_spf13_cobra \
  com_github_yosssi_ace \
  com_github_kardianos_osext \
  com_github_spf13_fsync \
  org_golang_x_sys \
  com_github_pmezard_go_difflib \
  com_github_davecgh_go_spew \
  com_github_PuerkitoBio_urlesc \
  com_github_PuerkitoBio_purell \
  org_golang_x_net \
  com_github_pelletier_go_toml \
  com_github_hashicorp_hcl \
  com_github_magiconair_properties \
  com_github_hashicorp_golang_lru \
  com_github_cpuguy83_go_md2man \
  com_github_magiconair_properties

# And now the ones where you can't use wtool on the name, only the import path
./bazel-bin/external/io_bazel_rules_go/go/tools/wtool/wtool -asis gopkg.in/yaml.v2 github.com/shurcooL/sanitized_anchor_name

# And finally we are ready to build
bazel test //...
```