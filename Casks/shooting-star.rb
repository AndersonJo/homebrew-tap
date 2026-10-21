cask "shooting-star" do
  version "0.1.0"
  sha256 "9d83b453f1f74ed1db6abcfe8b6ea047066b8da3c9f967d75972a0a8eb3ec974"

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
