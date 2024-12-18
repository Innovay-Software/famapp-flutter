# Famapp Flutter

A new Flutter project.

## Getting Started




#### Design
- Famapp uses Model-view-viewmodel architectural pattern


#### Key Concepts
- API endpoints are auto generated based on the provided OpenAPI specification.
- API Agent is responsible for talking to the generated API Endpoints
- This specification is shared between backend and frontend to prevent inconsistencies.
- Every use interaction is handled by "UseCases"
  - a "UseCase" might require a database update. It can a remote database update or local database update (updating local database)
  - a "UseCase" might not require a data update at all, for example, saving local prefs
  - in case of a remote database update, the UseCase calls the targeted API Agent, the API Agent will call the appropriate API endpoints
  - no http API calls will be initiated without going through the API Agent

- DataSource handles the local/remote database update, it does not handle business logics
- "UseCase" handles business logic updates based on the DataSource result.


#### OpenAPI code generation (https://github.com/OpenAPITools/openapi-generator)
openapi-generator generate -i ./openapi_spec/apiMain.yaml -g dart -o ./openapi_gen