class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "86b63fd1a0b467b515e64fe6dfd34ad7e5eb5b73ffc9219657c08065f8b4ea2f"
  license "MIT"

  depends_on :macos
  depends_on "popt"

  resource "binary" do
    on_arm do
      url "https://github.com/marcransome/flog/releases/download/v1.5.0/flog-v1.5.0-darwin-arm64.tar.xz"
      sha256 "81c8f8d1f2e72d0f87d8739f3a0a73c3c43795b770d13b05d30108658ec00b9a"
    end

    on_intel do
      url "https://github.com/marcransome/flog/releases/download/v1.5.0/flog-v1.5.0-darwin-x86_64.tar.xz"
      sha256 "db781391d7de7315a12ebdc0cd2d2611049ca9578f7eb9b7de229400e0359da8"
    end
  end

  def install
    resource("binary").stage do
      bin.install "bin/flog"
      man1.install "usr/share/man/man1/flog.1"
    end
  end

  test do
    assert_predicate bin/"flog", :exist?
    assert_predicate bin/"flog", :executable?
    assert_equal "flog v1.5.0", shell_output("#{bin}/flog --version").chomp
    system bin/"flog",
        "--subsystem", "uk.co.fidgetbox.flog",
        "--category", "internal",
        "--level", "debug",
        "--append", testpath/"output.txt",
        "Flog v1.5.0 test message"
    assert_predicate testpath/"output.txt", :exist?
    assert_match "Flog v1.5.0 test message", shell_output("cat #{testpath}/output.txt").chomp
  end
end
