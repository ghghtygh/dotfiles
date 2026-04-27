# dotfiles

개인 터미널 환경 설정 모음. 현재 tmux 설정과 플러그인 부트스트랩을 포함합니다.

## 구조

```
dotfiles/
├── install.sh        # symlink + TPM 부트스트랩 + 셸 alias 등록
├── shell/
│   └── aliases.sh    # dotpull, tmr 등 alias 정의
└── tmux/
    └── tmux.conf
```

설치 후 `~/.tmux.conf`는 `~/dotfiles/tmux/tmux.conf`를 가리키는 symlink가 됩니다.

---

## 사전 준비

### macOS

```bash
brew install git tmux gh
```

### Linux (Debian/Ubuntu)

```bash
sudo apt update
sudo apt install -y git tmux
# gh CLI: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
```

### Linux (Fedora/RHEL)

```bash
sudo dnf install -y git tmux gh
```

### Windows (WSL 사용)

tmux는 Windows를 직접 지원하지 않으므로 **WSL(Windows Subsystem for Linux)** 위에서 사용합니다.

1. PowerShell을 **관리자 권한**으로 실행 후:

   ```powershell
   wsl --install
   ```

   재부팅 후 Ubuntu가 자동 설치되며, 사용자명/비밀번호를 설정합니다.

2. WSL(Ubuntu) 터미널에서 위의 **Linux (Debian/Ubuntu)** 절차를 그대로 진행합니다.

> 이후 모든 명령은 Windows의 cmd/PowerShell이 아니라 **WSL 셸 안에서** 실행해야 합니다. (`install.sh`는 bash 스크립트라 WSL/Linux/macOS 모두 동일하게 동작합니다.)

---

## GitHub 인증 (private 레포)

```bash
gh auth login
```

안내에 따라 GitHub 계정으로 로그인하고, "Authenticate Git with your GitHub credentials?" 질문에 **Yes**를 선택합니다.

> SSH 키 방식이 익숙하다면 그걸 사용해도 됩니다.

---

## 설치

```bash
git clone https://github.com/ghghtygh/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

`install.sh`가 자동으로 처리하는 것:

- `~/.tmux.conf` → `~/dotfiles/tmux/tmux.conf` symlink 생성
- 기존 `~/.tmux.conf`가 있으면 `~/.tmux.conf.backup`으로 백업
- TPM(Tmux Plugin Manager)을 `~/.tmux/plugins/tpm`에 clone

## 플러그인 설치

```bash
tmux
```

tmux 안에서 **`Ctrl-a` + `Shift-i`** (대문자 I) 입력 → TPM이 `tmux.conf`에 선언된 플러그인을 자동 다운로드합니다. "Done, press ENTER to continue" 메시지가 나오면 완료입니다.

플러그인 목록은 [설정 상세](#설정-상세) 섹션을 참고하세요.

---

## 터미널 권장 설정 (선택)

기본은 `mouse on`이라 tmux가 마우스를 처리합니다. 추가로 iTerm 설정을 잡아두면 좋은 항목:

| 설정 | 위치 | 효과 |
|---|---|---|
| OSC 52 허용 | iTerm Settings → General → Selection → "Applications in terminal may access clipboard" | 원격 SSH 안 tmux의 OSC 52 클립보드 동작 |

### 마우스 native 동작이 필요할 때

tmux mouse on이라 기본 클릭은 tmux로 들어갑니다. 터미널 native 동작이 필요할 땐 modifier로 우회:

| 동작 | 키 |
|---|---|
| 링크 열기 | `⌘ + 클릭` (iTerm이 직접 처리) |
| native 드래그 (tmux 우회) | `Option + 드래그` |
| 마우스 통제권 토글 | `prefix + m` (mouse on/off 전환) |

### 휠 스크롤

마우스 휠을 굴리면 자동으로 tmux 복사 모드로 진입해 스크롤백을 보여줍니다 (`history-limit` 50000줄). `q` 또는 `Esc`로 빠져나오면 평소 모드 복귀.

---

## 동기화

### 변경 사항 push

```bash
cd ~/dotfiles
git add .
git commit -m "..."
git push
```

### 다른 PC에서 받기

```bash
dotpull           # = cd ~/dotfiles && git pull && tmux source-file ~/.tmux.conf
```

또는 수동으로:
```bash
cd ~/dotfiles && git pull
tmr               # = tmux source-file ~/.tmux.conf  (또는 tmux 안에서 prefix + r)
```

### 등록되는 셸 alias

`install.sh` 실행 시 `~/.zshrc` / `~/.bashrc`에 alias 파일이 자동 source됩니다.

| alias | 동작 |
|---|---|
| `dotpull` | dotfiles `git pull` 후 tmux conf 리로드 |
| `tmr` | 현재 tmux 서버에 conf 리로드만 |

---

## 설정 상세

### 설치된 플러그인

| 플러그인 | 설명 |
|---|---|
| `tmux-plugins/tpm` | Tmux Plugin Manager (필수, 부트스트랩 대상) |
| `tmux-plugins/tmux-sensible` | 합리적 기본 옵션 일괄 적용 |
| `tmux-plugins/tmux-resurrect` | 세션·창·pane 상태 저장/복원 |
| `tmux-plugins/tmux-continuum` | 일정 간격 자동 저장 + 시작 시 자동 복원 |
| `dracula/tmux` | Dracula 컬러 테마 + 상태바 위젯 |

### 변경된 키 바인딩

| 동작 | 기본 | 변경 |
|---|---|---|
| Prefix | `Ctrl-b` | `Ctrl-a` |
| 수평 분할 (좌우) | `prefix + %` | `prefix + \|` |
| 수직 분할 (상하) | `prefix + "` | `prefix + -` |
| pane 이동 (좌) | `prefix + ←` | `prefix + h` |
| pane 이동 (하) | `prefix + ↓` | `prefix + j` |
| pane 이동 (상) | `prefix + ↑` | `prefix + k` |
| pane 이동 (우) | `prefix + →` | `prefix + l` |
| conf 리로드 | (없음) | `prefix + r` |
| 마우스 on/off 토글 | (없음) | `prefix + m` |

> 분할 시 현재 pane의 작업 디렉토리를 새 pane에서도 유지합니다 (`-c "#{pane_current_path}"`).

### 복사 모드 (vi 키)

| 동작 | 키 |
|---|---|
| 복사 모드 진입 | `prefix + [` |
| 한 줄 위/아래 스크롤 | `Alt-↑` / `Alt-↓` |
| 반 페이지 스크롤 | `Alt-PageUp` / `Alt-PageDown` |
| 한 페이지 스크롤 | `PageUp` / `PageDown` |
| 선택 영역 클립보드 복사 | `y` |
| 마우스 드래그로 클립보드 복사 | 드래그 후 마우스 떼기 (자동) |

> 클립보드 명령은 OS 자동 감지: `pbcopy`(macOS) → `wl-copy`(Wayland) → `xclip`(X11) → `clip.exe`(WSL).

### 일반 옵션

| 옵션 | 값 | 설명 |
|---|---|---|
| `default-terminal` | `tmux-256color` | 256색 터미널 |
| 트루컬러 | `Tc` 적용 | xterm-256color, tmux-256color에 활성화 |
| `history-limit` | `50000` | 스크롤백 라인 수 |
| `mouse` | `on` | tmux가 마우스 처리 — pane별 정확한 드래그 복사·휠 스크롤·pane 선택 |
| `default-shell` | `/bin/zsh` (있을 시) | 기본 셸을 zsh로 강제 (없으면 시스템 기본) |
| `escape-time` | `0` | ESC 입력 지연 제거 (vim 친화적) |
| `base-index` | `1` | 창 번호를 1부터 시작 |
| `pane-base-index` | `1` | pane 번호를 1부터 시작 |
| `renumber-windows` | `on` | 창 닫으면 번호 자동 재정렬 |
| `mode-keys` | `vi` | 복사 모드에서 vi 키 사용 |
| `extended-keys` | `on` | Shift+Enter 등 modifier 키 조합 전달 |
| `terminal-features` | `xterm*:extkeys` | 터미널에 extkeys 지원 명시 |
| `set-clipboard` | `on` | OSC 52 활성 (원격 SSH에서도 로컬 클립보드 전송) |

### 세션 자동 저장/복원

`tmux-continuum`의 `@continuum-restore 'on'` 설정으로 tmux 시작 시 직전 세션이 자동 복원됩니다.

| 동작 | 키 |
|---|---|
| 세션 수동 저장 | `prefix + Ctrl-s` |
| 세션 수동 복원 | `prefix + Ctrl-r` |

### Dracula 테마 커스텀

| 항목 | 설정 | 효과 |
|---|---|---|
| 표시 위젯 | `git cpu-usage ram-usage time` | 우측 상태바에 표시 |
| Powerline | `false` | 화살표 구분자 끄기 (미니멀 룩) |
| 좌측 아이콘 | `session` | 좌측에 세션 이름 표시 |
| 시간 포맷 | `%m/%d %H:%M` | 월/일 시:분 |
| Git 현재 심볼 | `✓` | clean 상태 표시 |
| Git diff 심볼 | `!` | 변경사항 있을 때 표시 |
| CPU/RAM 라벨 | `CPU` / `RAM` | 짧은 라벨 사용 |
| 네트워크 / 날씨 / 배터리 | `false` | 사용 안 함 |
| 창 포맷 | `#I:#W` | 인덱스:이름 |
| 현재 창 포맷 | `#I:#W:<cwd>` | 활성 창에 현재 디렉토리명 표시 |
