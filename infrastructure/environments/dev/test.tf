# test.tf（テスト用ファイル）
data "google_project" "direct_test" {
  project_id = "branubrain-fs"
}

output "direct_test_result" {
  value = data.google_project.direct_test.project_id
}