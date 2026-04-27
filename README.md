# dotfiles

개인 터미널 환경 설정 모음. 현재 tmux 설정과 플러그인 부트스트랩을 포함합니다.

## 구조

```
dotfiles/
├── install.sh        # symlink + TPM 부트스트랩
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

설치되는 플러그인:

- `tmux-plugins/tpm` — 플러그인 매니저
- `tmux-plugins/tmux-sensible` — 합리적 기본 설정
- `tmux-plugins/tmux-resurrect` — 세션 저장/복원
- `tmux-plugins/tmux-continuum` — 자동 저장
- `dracula/tmux` — Dracula 테마

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
cd ~/dotfiles
git pull
```

설정 리로드는 tmux 안에서 `Ctrl-a` 후 `:source-file ~/.tmux.conf` 입력 (또는 tmux 재시작).

---

## 주요 키 바인딩

- **Prefix:** `Ctrl-a` (기본 `Ctrl-b` 대신)
- **창 분할:** prefix + `|` (수평) / prefix + `-` (수직)
- **pane 이동:** prefix + `h/j/k/l` (vim 스타일)
- **플러그인 설치:** prefix + `Shift-i`
- **세션 저장:** prefix + `Ctrl-s`
- **세션 복원:** prefix + `Ctrl-r`
