# cloud.suvisdev — 에이전트 안내

## Titanic 모듈 — 사용할 경로 (삭제·옛 경로 사용 금지)

| 역할 | 경로 |
|------|------|
| CSV 업로드 API | `POST /titanic/james/upload` → `crew_james_director_router.py` |
| Schema | `adapter/inbound/api/schemas/crew_james_director_schema.py` |
| 입력 포트 (ABC) | `app/ports/input/crew_james_director_use_case.py` |
| 업로드 유스케이스 | `app/use_cases/crew_james_director_interactor.py` |
| 업로드 호출 흐름 | `crew_james_director_router` → `JamesInteractor` → `crew_james_director_repository` → `crew_james_director_pg_repository` |
| 업로드 출력 포트 (ABC) | `app/ports/output/crew_james_director_repository.py` |
| 업로드 DB | `adapter/outbound/pg/crew_james_director_pg_repository.py` |
| Person ORM | `adapter/outbound/orm/passenger_rose_model_orm.py` |
| Booking ORM | `adapter/outbound/orm/passenger_jack_trainer_orm.py` |
| Walter 소개 API | `GET /titanic/walter/myself` → `crew_walter_roaster_router.py` |
| Walter Schema | `adapter/inbound/api/schemas/crew_walter_roaster_schema.py` |
| Walter 입력 포트 | `app/ports/input/crew_walter_roaster_use_case.py` |
| Walter 유스케이스 | `app/use_cases/crew_walter_roaster_interactor.py` |
| Walter 출력 포트 | `app/ports/output/crew_walter_roaster_repository.py` |
| Walter DB | `adapter/outbound/pg/crew_walter_roaster_pg_repository.py` |
| DTO | `app/dtos/crew_james_director_dto.py`, `crew_walter_roaster_dto.py` |
| DI | `dependencies/{schema_base}.py` — 예: `crew_smith_captain.py` → `get_crew_smith_captain_use_case` |

### Schema 파일명 = 레이어 접두·접미사 기준

| schema | router | use_case | interactor | repository | pg_repository | dependencies |
|--------|--------|----------|------------|------------|---------------|--------------|
| `crew_james_director_schema` | `crew_james_director_router` | `crew_james_director_use_case` | `crew_james_director_interactor` | `crew_james_director_repository` | `crew_james_director_pg_repository` | `crew_james_director.py` |
| `crew_walter_roaster_schema` | `crew_walter_roaster_router` | … | … | … | … | `crew_walter_roaster.py` |
| `crew_andrews_architect_schema` | `crew_andrews_architect_router` | … | … | … | … | `crew_andrews_architect.py` |
| `crew_hartley_violin_schema` | `crew_hartley_violin_router` | … | … | … | … | `crew_hartley_violin.py` |
| `crew_smith_captain_schema` | `crew_smith_captain_router` | … | … | … | … | `crew_smith_captain.py` |
| `crew_lowe_boat_schema` | `crew_lowe_boat_router` | … | … | … | … | `crew_lowe_boat.py` |
| `passenger_cal_tester_schema` | `passenger_cal_tester_router` | … | … | … | … | `passenger_cal_tester.py` |
| `passenger_isidor_couple_schema` | `passenger_isidor_couple_router` | … | … | … | … | `passenger_isidor_couple.py` |
| `passenger_jack_trainer_schema` | `passenger_jack_trainer_router` | … | … | … | … | `passenger_jack_trainer.py` |
| `passenger_rose_model_schema` | `passenger_rose_model_router` | … | ORM: `passenger_rose_model_orm` | … | … | `passenger_rose_model.py` |
| `passenger_ruth_validation_schema` | `passenger_ruth_validation_router` | … | … | … | … | `passenger_ruth_validation.py` |
| `passenger_molly_scaler_schema` | `passenger_molly_scaler_router` | … | … | … | … | `passenger_molly_scaler.py` |

ORM(James 업로드): `passenger_rose_model_orm`(Person), `passenger_jack_trainer_orm`(Booking)

## Viewer 인증 — login / signup (`friday13th`는 수업용, 인증은 viewer)

| 역할 | 경로 |
|------|------|
| 로그인 API | `POST /viewer/login/login` → `login_router.py` |
| 로그인 흐름 | `login_router` → `LoginInteractor` → `login_pg_repository` |
| 로그인 입력 포트 (ABC) | `suvisdev/apps/viewer/app/ports/input/login_use_case.py` |
| 로그인 출력 포트 (ABC) | `suvisdev/apps/viewer/app/ports/output/login_repository.py` |
| 회원가입 API | `POST /viewer/signup/signup` → `signup_router.py` |
| 회원가입 흐름 | `signup_router` → `SignupInteractor` → `signup_pg_repository` |
| 계정 ORM | `suvisdev/apps/viewer/app/dtos/` — `groups`, `admins`, `users` |

### 존재하지 않음 (참조하지 말 것)

- `/friday13th/jason/*`, `jason_router`, `JasonInteractor` (login/signup으로 이전됨)
- `suvisdev/apps/titanic/app/walter_reader.py` (삭제됨)
- `suvisdev/apps/titanic/app/use_cases/james_command.py` (삭제됨 — `james_interactor.py` 사용)
- `services/cloud.suvisdev.agora/...` (이 repo 아님)
- `docs/DevOps/Backend/MOVA_ERD.md` — Mova ERD **단일 문서** (mermaid 블록 + `mova-erd.png` 미리보기). PNG: `python docs/DevOps/Backend/export_mova_erd_png.py`
