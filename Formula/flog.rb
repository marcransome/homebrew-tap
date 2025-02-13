class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/refs/tags/v1.7.0.tar.gz"
  sha256 "19a9333b553264f388cb93e0c0dbe4c5b629f3edcdc3eb02afd4776b96e6e525"
  license "MIT"

  depends_on :macos
  depends_on "popt"

  resource "binary" do
    on_arm do
      url "https://github.com/marcransome/flog/releases/download/v1.7.0/flog-v1.7.0-darwin-arm64.tar.xz"
      sha256 "989d8d868fb134b64f3275c092c88b108b6629c8ebc2e7280b20ed51a270e690"
    end

    on_intel do
      url "https://github.com/marcransome/flog/releases/download/v1.7.0/flog-v1.7.0-darwin-x86_64.tar.xz"
      sha256 "6791701cd487c9106900aaef3840fa9be1d3f8ca1469089616b0bbe4f96ef4d3"
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
    assert_equal "flog v1.7.0", shell_output("#{bin}/flog --version").chomp
    system bin/"flog",
        "--subsystem", "uk.co.fidgetbox.flog",
        "--category", "internal",
        "--level", "debug",
        "--append", testpath/"output.txt",
        "Flog v1.7.0 test message"
    assert_predicate testpath/"output.txt", :exist?
    assert_match "Flog v1.7.0 test message", shell_output("cat #{testpath}/output.txt").chomp
  end
end
