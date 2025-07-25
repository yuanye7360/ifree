#!/bin/bash

# Stacked PR 自動化腳本
# 功能：自動創建、同步、發起整個 stack 的 PR

set -e

# 顏色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 打印帶顏色的消息
print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# 生成 PR 描述模板
generate_pr_description() {
    local branch_name=$1
    local parent_branch=$2

    cat << EOF
## 📋 概述
此 PR 實現了 \`$branch_name\` 功能

## 🔗 依賴關係
- **基於分支**: \`$parent_branch\`
- **Stack 位置**: $(get_stack_position "$branch_name")

## 📝 變更內容
- [ ] 功能實現
- [ ] 測試覆蓋
- [ ] 文檔更新

## 🧪 測試
- [ ] 單元測試通過
- [ ] 集成測試通過
- [ ] 手動測試完成

## 📚 相關文檔
- 功能說明: \`docs/$branch_name.md\`
- API 文檔: \`docs/api/$branch_name.md\`

## 🔄 後續步驟
1. Code Review
2. 測試驗證
3. 合併到 \`$parent_branch\`

---
*此 PR 由 Stacked PR 自動化腳本生成*
EOF
}

# 獲取分支在 stack 中的位置
get_stack_position() {
    local branch_name=$1
    local position=1

    # 簡單的位置計算（可以根據實際需求調整）
    case $branch_name in
        feature/a) echo "第 1 層 (基礎功能)" ;;
        feature/b) echo "第 2 層 (依賴 feature/a)" ;;
        feature/c) echo "第 3 層 (依賴 feature/b)" ;;
        feature/d) echo "第 4 層 (依賴 feature/c)" ;;
        *) echo "第 $position 層" ;;
    esac
}

# 獲取父分支
get_parent_branch() {
    local branch_name=$1

    case $branch_name in
        feature/a) echo "develop" ;;
        feature/b) echo "feature/a" ;;
        feature/c) echo "feature/b" ;;
        feature/d) echo "feature/c" ;;
        *) echo "develop" ;;
    esac
}

# 創建分支文檔
create_branch_docs() {
    local branch_name=$1
    local docs_dir="docs"

    # 創建 docs 目錄
    mkdir -p "$docs_dir"

    # 創建功能文檔
    cat > "$docs_dir/$branch_name.md" << EOF
# $branch_name

## 功能描述
此功能實現了 $branch_name 相關功能。

## 技術實現
- 實現方式：待補充
- 依賴關係：$(get_parent_branch "$branch_name")
- 測試覆蓋：待補充

## API 接口
\`\`\`
// 待補充 API 文檔
\`\`\`

## 使用示例
\`\`\`
// 待補充使用示例
\`\`\`

## 變更記錄
- $(date '+%Y-%m-%d'): 初始實現
EOF

    # 創建 API 文檔
    mkdir -p "$docs_dir/api"
    cat > "$docs_dir/api/$branch_name.md" << EOF
# $branch_name API

## 接口列表

### 1. 主要接口
\`\`\`
// 待補充接口定義
\`\`\`

## 錯誤碼
| 錯誤碼 | 描述 |
|--------|------|
| 待補充 | 待補充 |

## 版本歷史
- v1.0.0: 初始版本
EOF

    print_success "已創建 $branch_name 的文檔"
}

# 主要函數：創建 Stacked PR
create_stacked_pr() {
    local branch_name=$1
    local parent_branch=$(get_parent_branch "$branch_name")

    print_info "開始創建 Stacked PR: $branch_name"

    # 1. 確保在正確的父分支上
    print_info "切換到父分支: $parent_branch"
    git checkout "$parent_branch"
    git pull origin "$parent_branch"

    # 2. 創建新分支
    print_info "創建分支: $branch_name"
    git-town append "$branch_name"

    # 3. 創建文檔
    print_info "創建分支文檔"
    create_branch_docs "$branch_name"

    # 4. 提交更改
    print_info "提交更改"
    git add .
    git commit -m "feat: add $branch_name functionality and docs"

    # 5. 推送分支
    print_info "推送分支到遠程"
    git push -u origin "$branch_name"

    # 6. 生成 PR 描述
    local pr_description=$(generate_pr_description "$branch_name" "$parent_branch")
    local pr_description_file="/tmp/pr_description_$branch_name.md"
    echo "$pr_description" > "$pr_description_file"

    # 7. 創建 PR
    print_info "創建 Pull Request"
    gh pr create \
        --title "feat: add $branch_name functionality" \
        --body-file "$pr_description_file" \
        --base "$parent_branch"

    # 清理臨時文件
    rm -f "$pr_description_file"

    print_success "✅ Stacked PR 創建完成！"
    print_info "分支: $branch_name"
    print_info "基於: $parent_branch"
    print_info "文檔: docs/$branch_name.md"
}

# 同步整個 stack
sync_stack() {
    print_info "同步整個 Stack"
    git-town sync --all
    print_success "Stack 同步完成"
}

# 顯示 stack 狀態
show_stack_status() {
    print_info "當前 Stack 狀態："
    git-town config | grep -A 10 "Branch Lineage"
}

# 主程序
main() {
    case "${1:-}" in
        "create")
            if [ -z "$2" ]; then
                print_error "請提供分支名"
                echo "用法: $0 create <分支名>"
                exit 1
            fi
            create_stacked_pr "$2"
            ;;
        "sync")
            sync_stack
            ;;
        "status")
            show_stack_status
            ;;
        "help"|"-h"|"--help")
            cat << EOF
Stacked PR 自動化工具

用法:
  $0 create <分支名>    創建新的 Stacked PR
  $0 sync             同步整個 stack
  $0 status           顯示 stack 狀態
  $0 help             顯示此幫助

示例:
  $0 create feature/e
  $0 sync
  $0 status

功能:
  ✅ 自動創建分支和文檔
  ✅ 自動生成 PR 描述
  ✅ 自動建立 PR 關係
  ✅ 自動同步整個 stack
EOF
            ;;
        *)
            print_error "未知命令: $1"
            echo "使用 '$0 help' 查看幫助"
            exit 1
            ;;
    esac
}

# 執行主程序
main "$@"