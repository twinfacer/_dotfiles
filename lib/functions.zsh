# Small shortcut for creating and cd'ing into <TARGET_DIR>
take() {
  mkdir -p $1
  cd $1
}

# Check binary existence
callable() {
  mute which $1
}
