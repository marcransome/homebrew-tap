class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/refs/tags/v1.9.0.tar.gz"
  sha256 "f47a0029de9127cb5ec65073ed34e9ba6db2f20f2f664069af0cca52859f7da4"
  license "MIT"

  depends_on :macos
  depends_on "popt"

  resource "binary" do
    on_arm do
      url "https://github.com/marcransome/flog/releases/download/v1.9.0/flog-v1.9.0-darwin-arm64.tar.xz"
      sha256 "9cee964e089d7501e2edbd852ccad483bd84bac2c420b2fa5ec123a491e46dc4"
    end

    on_intel do
      url "https://github.com/marcransome/flog/releases/download/v1.9.0/flog-v1.9.0-darwin-x86_64.tar.xz"
      sha256 "42ecd1c48ba772ad3060a0007701c5a4a367b7b1843c1dac24cf9f1b6b051a33"
    end
  end

  def install
    resource("binary").stage do
      bin.install "bin/flog"
      man1.install "usr/share/man/man1/flog.1"
    end
  end

  test do
    assert_path_exists bin/"flog"
    assert_predicate bin/"flog", :executable?
    assert_path_exists prefix/"README.md"
    assert_path_exists prefix/"LICENSE"
    assert_equal "flog v1.9.0", shell_output("#{bin}/flog --version").chomp
    system bin/"flog",
        "--subsystem", "uk.co.fidgetbox.flog",
        "--category", "internal",
        "--level", "debug",
        "--append", testpath/"output.txt",
        "Flog v1.9.0 test message"
    assert_path_exists testpath/"output.txt"
    assert_match "Flog v1.9.0 test message", shell_output("cat #{testpath}/output.txt").chomp
  end
end
