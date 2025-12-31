class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/refs/tags/v1.7.3.tar.gz"
  sha256 "41c251ecdea78927b9284b6a64e456ebd5468c008ee5c0e9962f9e5c1c469110"
  license "MIT"

  depends_on :macos
  depends_on "popt"

  resource "binary" do
    on_arm do
      url "https://github.com/marcransome/flog/releases/download/v1.7.3/flog-v1.7.3-darwin-arm64.tar.xz"
      sha256 "95c1020f1f786cae7080adcabeeb1870ec71035c1ab6c9c221a0d0c305a2b96b"
    end

    on_intel do
      url "https://github.com/marcransome/flog/releases/download/v1.7.3/flog-v1.7.3-darwin-x86_64.tar.xz"
      sha256 "022c417d193567ce7795579624f8b3eb9dad7ebb46f6f99b57523f7073aa8f0c"
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
    assert_equal "flog v1.7.3", shell_output("#{bin}/flog --version").chomp
    system bin/"flog",
        "--subsystem", "uk.co.fidgetbox.flog",
        "--category", "internal",
        "--level", "debug",
        "--append", testpath/"output.txt",
        "Flog v1.7.3 test message"
    assert_path_exists testpath/"output.txt"
    assert_match "Flog v1.7.3 test message", shell_output("cat #{testpath}/output.txt").chomp
  end
end
