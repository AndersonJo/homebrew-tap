cask "shooting-star" do
  version "0.2.0"
  sha256 "c9784adc9739cf0ca2d9f9cbfd9f064a406375e6488f26076ee3b1be5236bc10"

  url "https://github.com/AndersonJo/Shooting-Star-/releases/download/v#{version}/shooting-star-#{version}-macos.zip"
  name "shooting-star"
  desc "Lightweight local document manager for markdown, yaml, csv and json"
  homepage "https://github.com/AndersonJo/Shooting-Star-"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on formula: "node"
  depends_on macos: :ventura

  app "shooting-star.app"
  binary "#{appdir}/shooting-star.app/Contents/Resources/ss"

  # 개발자 ID 로 서명/공증되지 않은 앱이라 Gatekeeper 경고가 뜨지 않도록 격리 속성을 제거한다.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/shooting-star.app"],
        must_succeed: false
  end

  # 메모(~/.shooting-star)는 사용자 데이터라 삭제 대상에 넣지 않는다.
  zap trash: "~/.config/shooting-star"
end
