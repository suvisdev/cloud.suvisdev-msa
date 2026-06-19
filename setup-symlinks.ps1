# cloud.suvisdev 심볼릭 링크 설정 스크립트
# 실행 방법: PowerShell에서 .\setup-symlinks.ps1

$root = Split-Path -Parent $MyInvocation.MyCommand.Path

$links = @(
    @{
        Link   = Join-Path $root "suvis\CLAUDE.md"
        Target = Join-Path $root "vault\suvis\CLAUDE.MD"
    },
    @{
        Link   = Join-Path $root "suvisdev\CLAUDE.md"
        Target = Join-Path $root "vault\suvisdev\CLAUDE.MD"
    }
)

foreach ($entry in $links) {
    if (Test-Path $entry.Link) {
        $existing = Get-Item $entry.Link -ErrorAction SilentlyContinue
        if ($existing.LinkType -eq "SymbolicLink") {
            Write-Host "이미 심볼릭 링크: $($entry.Link)" -ForegroundColor Yellow
            continue
        }
        Remove-Item $entry.Link -Force
    }

    New-Item -ItemType SymbolicLink -Path $entry.Link -Target $entry.Target | Out-Null
    Write-Host "심볼릭 링크 생성: $($entry.Link)" -ForegroundColor Green
    Write-Host "          → $($entry.Target)" -ForegroundColor DarkGray
}

Write-Host "`n완료." -ForegroundColor Cyan
