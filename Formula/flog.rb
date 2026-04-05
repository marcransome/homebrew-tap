class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/refs/tags/v1.8.0.tar.gz"
  sha256 "d6274c987cefbff14a470e1b642b76839faff7c7993d7a7dc0700b75c27f2db5"
  license "MIT"

  depends_on :macos
  depends_on "popt"

  resource "binary" do
    on_arm do
      url "https://github.com/marcransome/flog/releases/download/v1.8.0/flog-v1.8.0-darwin-arm64.tar.xz"
      sha256 "48068971a64dd5ab7a617dba293c7ee64ef51eb92b0b49ef2e22ef62984eed61"
    end

    on_intel do
      url "https://github.com/marcransome/flog/releases/download/v1.8.0/flog-v1.8.0-darwin-x86_64.tar.xz"
      sha256 "0a4dfca9d5668824b9dd50b9c2881a0c10ddbe91ec7cada82180a4381fe0609c"
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
    assert_equal "flog v1.8.0", shell_output("#{bin}/flog --version").chomp
    system bin/"flog",
        "--subsystem", "uk.co.fidgetbox.flog",
        "--category", "internal",
        "--level", "debug",
        "--append", testpath/"output.txt",
        "Flog v1.8.0 test message"
    assert_path_exists testpath/"output.txt"
    assert_match "Flog v1.8.0 test message", shell_output("cat #{testpath}/output.txt").chomp
  end
end
