class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/refs/tags/v1.6.4.tar.gz"
  sha256 "bff9d6fc5c11e1b8225a4249467881d5acb0441a022d4b4afaa280d2e06808a0"
  license "MIT"

  depends_on :macos
  depends_on "popt"

  resource "binary" do
    on_arm do
      url "https://github.com/marcransome/flog/releases/download/v1.6.4/flog-v1.6.4-darwin-arm64.tar.xz"
      sha256 "967e786488873295d1733ea379c3394a3d1da8fdf0d132cc5310f50f8a8956c8"
    end

    on_intel do
      url "https://github.com/marcransome/flog/releases/download/v1.6.4/flog-v1.6.4-darwin-x86_64.tar.xz"
      sha256 "2463a0f53507eaccd91836ba6d340850fb917d25f05fbd816f49a50d3d3e5e19"
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
    assert_predicate prefix/"README.md", :exist?
    assert_predicate prefix/"LICENSE", :exist?
    assert_equal "flog v1.6.4", shell_output("#{bin}/flog --version").chomp
    system bin/"flog",
        "--subsystem", "uk.co.fidgetbox.flog",
        "--category", "internal",
        "--level", "debug",
        "--append", testpath/"output.txt",
        "Flog v1.6.4 test message"
    assert_predicate testpath/"output.txt", :exist?
    assert_match "Flog v1.6.4 test message", shell_output("cat #{testpath}/output.txt").chomp
  end
end
