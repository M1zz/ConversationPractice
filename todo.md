# 작업 목록

## 완료 - 1차 커밋
- [x] CategoryView.swift - CategoryCard의 padding.horizontal 제거하여 CustomScenarioCard와 너비 맞춤
- [x] .claude-instructions 파일 생성 - Claude Code 작업 지시사항 추가
- [x] README.md 업데이트 - Claude Code 작업 규칙 명시
- [x] todo.md 생성 - 작업 목록 문서화

## 완료 - 2차 커밋
- [x] ConversationView.swift - TTS 재생 중 상태 추가 및 UX 개선
- [x] ScriptViewerView.swift - 배경색 추가 및 UI 개선
- [x] SUPPORT_EN.md, SUPPORT_KR.md - 지원 가이드 문서 추가
- [x] todo.md 업데이트 - 2차 커밋 내용 반영

## 완료 - 분기형 대화 빌더 구현
- [x] Phase 1: 데이터 모델 확장
  - [x] ScenarioCreationView.swift - TurnData에 branches: [BranchPath] 추가
  - [x] ScenarioCreationView.swift - BranchPath 모델 추가
  - [x] ScenarioDraft 버전 관리 추가 (version 2)
  - [x] CustomScenario.swift - ConversationTurn에 BranchTurn 추가
- [x] Phase 2: 편집 UI 구현
  - [x] BranchPathSelector 컴포넌트 추가
  - [x] BranchEditorView 컴포넌트 추가
  - [x] BranchTab 컴포넌트 추가
  - [x] TurnRow 수정 - 분기 추가 버튼 및 분기 탭 표시
  - [x] OptionCard 수정 - 분기 여부 표시
- [x] Phase 3: 변환 로직 수정
  - [x] CustomScenario.buildConversationTree() 분기 지원 재구현
  - [x] convertTurnsToConversationTurns() 재귀적 분기 변환 함수 추가
- [x] Phase 4: 연습 UI 수정
  - [x] ConversationView.swift - 분기점 감지 로직 추가
  - [x] BranchSelectorSheet 컴포넌트 추가
  - [x] proceedWithBranch() 함수 추가

## 변경 사항 요약
- 내 시나리오와 상황별 시나리오의 카드 너비를 동일하게 맞춤
- 프로젝트에 Claude Code 작업 가이드라인 추가
- 음성 재생 중 사용자 인터페이스 개선
- 다국어 지원 문서 추가
