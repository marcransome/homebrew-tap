class Flog < Formula
  desc "Command-line tool for sending log messages to Apple's unified logging system"
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/1.1.0.tar.gz"
  sha256 "c7fb564998a7c6a06e05803b9e95510d3f37579e2eb1d645935cb80415a7892d"
  license "MIT"

  depends_on "cmake" => :build
  depends_on :macos

  def install
    if OS.mac? && Hardware::CPU.arm?
      opoo <<~ARM
        You appear to be intalling flog on a system with Apple M-series CPU
        (arm64); flog is currently untested on this architecture but should
        build and function correctly. Please comment on the GitHub discussion
        if you run into any issues:
        https://github.com/marcransome/flog/discussions/41
      ARM
    end

    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build", "--prefix", prefix.to_s

    man1.install "man/flog.1"
  end

  test do
    system "#{bin}/flog", "--level", "debug", "'test message'"
  end
end
