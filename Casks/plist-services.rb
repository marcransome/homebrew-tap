cask "plist-services" do
  version "1.0.0"
  sha256 "b6d23a413154eba7927dd184daa37c9cd62e1d25147bf53b47db7c5418b57fb3"

  url "https://github.com/marcransome/plist-services/archive/#{version}.tar.gz"
  name "plist-services"
  desc "macOS Quick Actions for converting property list files between XML and binary encodings"
  homepage "https://www.github.com/marcransome/plist-services"

  service "plist-services-#{version}/Convert to binary plist.workflow"
  service "plist-services-#{version}/Convert to XML plist.workflow"

  caveats do
    license "https://github.com/marcransome/plist-services/blob/#{version}/LICENSE"
  end
end
