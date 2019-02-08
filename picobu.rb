class Picobu < Formula
  desc "Picobu: Simple, one-command build system for PICO-8 games"
  homepage "https://github.com/Divoolej/picobu"
  url "https://github.com/Divoolej/picobu/archive/1.0.2.tar.gz"
  sha256 "c490aaea2bee635ab2d101da0c718d785dc3c392ff85c7bae6734f974e8ac230"

  depends_on "rust" => :build

  bottle do
    root_url "https://github.com/Divoolej/picobu/releases/download/1.0.2/"
    cellar :any_skip_relocation
    sha256 "aa0c95c56809e700f47d0a2c10e5dd3accca95fb1bc55f6c8cf335b8e0c3827d" => :mojave
  end

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    (testpath/"test.lua").write <<~EOS
      function main()
        print("test")
      end
    EOS
    system "#{bin}/picobu", "--input=./", "test.p8"
    assert_equal `cat test.p8`, <<~EOS
      pico-8 cartridge // http://www.pico-8.com
      version 16
      __lua__
      function main()
        print("test")
      end
      __gfx__
    EOS
  end
end
