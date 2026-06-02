# MyAppCICD

Oracle SQLcl Projects demo for database CI/CD using schema MYAPP.

## Local demo flow

1. Initialize the project once with `run/create_project.sh`.
2. Apply database changes manually in SQLcl using the scripts under the demo folder.
3. Capture each development cycle with `run/dev_cycle.sh <cycle_name>`.

## SQLcl connections

The project configuration keeps sqlcl.connectionName empty.
Development scripts pass this local connection explicitly:

```text
MIKE[MYAPP]
```

Future GitHub Actions jobs can use environment-specific connections or direct
credentials for validation, release, artifact generation, and deployment.

## Notes

- Local development cycles run `project export` and `project stage`.
- Release creation, artifact generation, and deployment are intentionally left for GitHub Actions.
- Export filters exclude DBTools/MCP support objects such as `DBTOOLS$MCP_LOG`.
