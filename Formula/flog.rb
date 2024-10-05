class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/refs/tags/v1.6.2.tar.gz"
  sha256 "2e1d784cc090a2fb8feb1c26084f829ac8ebb306960ac00ba495fb21475c31db"
  license "MIT"

  depends_on :macos
  depends_on "popt"

  resource "binary" do
    on_arm do
      url "https://github.com/marcransome/flog/releases/download/v1.6.2/flog-v1.6.2-darwin-arm64.tar.xz"
      sha256 "2694fe5f7b06a7efcb2545efad6579c63f855df74e48d55e55d543b5d1955238"
    end

    on_intel do
      url "https://github.com/marcransome/flog/releases/download/v1.6.2/flog-v1.6.2-darwin-x86_64.tar.xz"
      sha256 "349c05090c7423e61e40f024ffc7d47a6d54e3145af95d9a6cd10a86c745008b"
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
    assert_equal "flog v1.6.2", shell_output("#{bin}/flog --version").chomp
    system bin/"flog",
        "--subsystem", "uk.co.fidgetbox.flog",
        "--category", "internal",
        "--level", "debug",
        "--append", testpath/"output.txt",
        "Flog v1.6.2 test message"
    assert_predicate testpath/"output.txt", :exist?
    assert_match "Flog v1.6.2 test message", shell_output("cat #{testpath}/output.txt").chomp
  end
end
