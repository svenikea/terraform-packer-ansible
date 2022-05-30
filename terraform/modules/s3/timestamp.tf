locals {
  timestamp = "${timestamp()}"
  timestamp_filtered = "${replace("${local.timestamp}", "/[-| |T|Z|:]/", "")}"
}
