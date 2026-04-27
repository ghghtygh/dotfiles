# Contributing

이 dotfiles 레포에 기여해주셔서 감사합니다.

## 기여 절차

1. 레포 **Fork** → 작업 브랜치 생성
2. 변경 후 commit & push
3. GitHub에서 **Pull Request** 생성 (main 대상)

> `main` 브랜치에는 직접 push 불가 — PR을 통해서만 변경됩니다.

## 작업 가이드

### tmux.conf

- 새 옵션·키 바인딩 추가 시 `README.md`의 "설정 상세" 표도 업데이트해주세요.
- 기존 prefix(`Ctrl-a`) 및 vim 스타일 단축키와 충돌하지 않도록 주의해주세요.

### install.sh

- POSIX/bash 호환을 유지해주세요 (zsh 전용 문법 X).
- macOS, Linux, WSL 모두에서 동작해야 합니다.
- 외부 자원을 다운로드하는 명령(예: `curl | sh`)은 보안상 가급적 피해주세요.

### OS 의존 명령

`pbcopy`(macOS), `xclip`(Linux), `clip.exe`(WSL) 등 OS 종속 명령을 추가하는 경우 다른 OS 대비 안내(주석/대체 명령)를 함께 포함해주세요.

## 테스트

가능하다면 새 환경에서 다음 절차로 검증해주세요:

```bash
~/dotfiles/install.sh
tmux kill-server && tmux       # 새 서버에서 동작 확인
# tmux 안에서: prefix + I (대문자) 로 플러그인 재설치
```

## 보안

`install.sh`는 사용자 홈 디렉토리에서 실행됩니다. 출처가 불분명한 외부 코드를 가져오거나 권한을 광범위하게 변경하는 PR은 거절될 수 있습니다.

## 문의

질문은 [Issues](https://github.com/ghghtygh/dotfiles/issues)에 자유롭게 올려주세요.
