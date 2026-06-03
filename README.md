# MyAppCICD

Oracle SQLcl Projects demo for database CI/CD using schema MYAPP.

## Local demo flow

1. Initialize the project once with `run/create_project.sh`.
2. Apply database changes manually in SQLcl using the scripts under the demo folder.
3. Capture each development cycle with `run/dev_cycle.sh <cycle_name>`.

## GitHub Actions flow

- Development branch pushes run SQLcl Project verify.
- After a branch is merged to `main`, run the `SQLcl Project Release` workflow manually.
- The release workflow asks for a version, runs `project release`, runs `project gen-artifact`, commits the closed release state to `main`, and publishes the generated ZIP in GitHub Releases.
- Release and artifact generation do not require a database connection; deploy will be added later as a separate manual workflow.

## SQLcl connections

The project configuration keeps sqlcl.connectionName empty.
Development scripts pass this local connection explicitly:

```text
MIKE[MYAPP]
```

Future GitHub Actions jobs can use environment-specific connections or direct
credentials for validation, release, artifact generation, and deployment.
The validation workflow connects directly to Autonomous Database with
`connect -cloudconfig`; it does not create or reuse a saved SQLcl connection.

## Notes

- Local development cycles run `project export` and `project stage`.
- Release creation and artifact generation are handled by the manual GitHub Actions release workflow.
- Deployment is intentionally left for a later GitHub Actions phase.
- GitHub Actions workflows are installed by the local demo runner during project creation.
- Export filters exclude DBTools/MCP support objects such as `DBTOOLS$MCP_LOG`.
