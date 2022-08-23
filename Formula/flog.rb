class Flog < Formula
  desc "A command-line tool for sending log messages to Apple's unified logging system."
  homepage "https://github.com/marcransome/flog"
  url "https://github.com/marcransome/flog/archive/1.0.0.tar.gz"
  sha256 "c5846d2a19815e1dc548170bf01d122d48bd72195e26f3af03e9e6ff6b097e7d"
  license "MIT"

  depends_on "cmake" => :build
  depends_on macos: ">= :big_sur"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build", "--prefix", "#{prefix}"

    man1.install "man/flog.1"
  end

  test do
    system "#{bin}/flog --version"
  end
end
