class Picobu < Formula
  desc "Simple, one-command build system for PICO-8 games"
  homepage "https://github.com/Divoolej/picobu"
  url "https://github.com/Divoolej/picobu/archive/1.0.4.tar.gz"
  sha256 "d07bd4ca3d615489dec88ab2c442dc846afb6c45813877af2df4d6c37405dbe6"

  depends_on "rust" => :build

  bottle do
    root_url "https://github.com/Divoolej/picobu/releases/download/1.0.4"
    cellar :any_skip_relocation
    sha256 "11ceb8d218b06b8baba97f913e9f630a65a60cca63ef21f353ea09aa1ac160ea" => :mojave
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
