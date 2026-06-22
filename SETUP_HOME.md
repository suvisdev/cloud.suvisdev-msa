# 집에서 동일하게 환경 세팅하기 (Team-Seuk / Yaksok)

> Windows 10/11 + PowerShell 기준. 회사에서 진행한 2~4단계를 그대로 재현하는 순서다.
> 각 단계마다 **검증 포인트**가 있고, 거기서 OK가 나오면 다음으로 넘어가면 된다.

---

## 0. 사전 조건

- **Team-Seuk/Team-Seuk** repo는 **비공개(private)** — GitHub 조직(org) 멤버로 초대돼 있어야 보인다.
- **Team-Seuk/Yaksok** repo는 **공개(public)**.
- 비공개 repo 클론에는 GitHub 인증이 필요하다. **GitHub Desktop을 한 번이라도 로그인해두면** Windows 자격증명 관리자(credential manager)에 인증이 저장돼, 이후 `git clone`이 비밀번호 없이 동작한다.

---

## 2. uv + Node.js 설치

### 2-1. uv (Python 패키지 매니저)

PowerShell을 열고 붙여넣기:

```powershell
powershell -c "irm https://astral.sh/uv/install.ps1 | iex"
```

설치 후 **새 터미널을 열어야** PATH가 반영된다.

### 2-2. Node.js LTS (20 이상)

<https://nodejs.org/> 에서 **LTS** 버전 설치 (프론트 npm 실행에 필요).

### 2-3. 설치 확인 (검증)

```powershell
uv --version      # 예: uv 0.11.x
node --version    # v20 이상 (예: v24.x)
npm --version     # 예: 11.x
```

> 세 줄이 모두 버전을 출력하면 OK. 이미 깔려 있으면 재설치 불필요.

---

## 3. 저장소 받기 — 두 개를 순서대로

> ⚠️ **인덱스(Team-Seuk)를 먼저** 받아야 `C:\Team-Seuk`가 깨끗하게 생긴다.
> 인덱스 repo의 `.gitignore`가 `Yaksok/` 폴더를 자동 무시하므로 둘이 섞이지 않는다.

### 3-1. Team-Seuk (인덱스: 팀 공통 규칙·디자인 문서) → `C:\Team-Seuk`

**CLI:**
```powershell
git clone https://github.com/Team-Seuk/Team-Seuk.git C:\Team-Seuk
```

**또는 GitHub Desktop:** File → Clone repository → `Team-Seuk/Team-Seuk`
→ Local path 부모를 `C:\` 로 지정 → 최종 경로가 `C:\Team-Seuk` 가 되게.

### 3-2. Team-Seuk/Yaksok (프로젝트) → `C:\Team-Seuk\Yaksok`

**CLI:**
```powershell
git clone https://github.com/Team-Seuk/Yaksok.git C:\Team-Seuk\Yaksok
```

**또는 GitHub Desktop:** File → Clone repository → `Team-Seuk/Yaksok`
→ Local path 부모를 `C:\Team-Seuk` 로 지정 → 최종 경로가 `C:\Team-Seuk\Yaksok` 가 되게.

### 3-3. 확인 (검증)

```powershell
git -C C:\Team-Seuk      remote get-url origin   # .../Team-Seuk.git
git -C C:\Team-Seuk\Yaksok remote get-url origin # .../Yaksok.git
git -C C:\Team-Seuk      status --short          # 출력 없음(clean) = Yaksok 무시 정상
```

최종 구조:
```
C:\Team-Seuk\
├── CLAUDE.md / DESIGN.md / README.md   ← 팀 공통 문서
└── Yaksok\                             ← 프로젝트 repo (별도 git)
    ├── backend\
    └── frontend\
```

---

## 4. 환경 맞추기 — 백엔드·프론트 (모두 `C:\Team-Seuk\Yaksok` 안에서)

### 4-1. 백엔드

```powershell
cd C:\Team-Seuk\Yaksok\backend
uv sync          # .venv 생성 + 의존성 설치
uv run pytest    # 테스트 실행
```

**검증:** pytest가 `passed`로 끝나면 OK.
(예: `1 passed` — `StarletteDeprecationWarning` 경고는 무시해도 됨)

### 4-2. 프론트

```powershell
cd C:\Team-Seuk\Yaksok\frontend
npm install      # 의존성 설치 (Vite 프로젝트)
npm run dev      # 개발 서버 실행
```

**검증:** 터미널에 `http://localhost:5173/` 가 뜨고, 브라우저로 접속하면 **Yaksok 화면**이 보이면 OK.

> `npm install` 시 취약점(vulnerabilities) 경고가 떠도 무시. `npm audit fix --force`는 breaking change 위험이 있으니 함부로 돌리지 말 것.

---

## 빠른 체크리스트

- [ ] `uv --version` / `node --version`(≥20) / `npm --version` 출력됨
- [ ] `C:\Team-Seuk` 생성 + 팀 문서 보임
- [ ] `C:\Team-Seuk\Yaksok` 생성 (backend / frontend 존재)
- [ ] 백엔드: `uv sync` → `uv run pytest` **passed**
- [ ] 프론트: `npm install` → `npm run dev` → `localhost:5173` 화면 뜸

---

## 자주 막히는 곳

| 증상 | 원인 / 해결 |
|------|-------------|
| `uv` 명령을 못 찾음 | 설치 후 **새 터미널**을 열지 않음 → 터미널 재시작 |
| Team-Seuk 클론이 인증 실패 | org 멤버 아님, 또는 GitHub 로그인 안 됨 → **GitHub Desktop 로그인** 후 재시도 |
| `npm run dev` 포트 충돌 | 5173 사용 중 → 기존 Vite 종료하거나 Vite가 자동으로 다음 포트 사용 |
| pytest 수집 0건 / 경로 오류 | `backend` 폴더 안에서 실행했는지 확인 (`cd C:\Team-Seuk\Yaksok\backend`) |
