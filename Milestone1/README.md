# Milestone 1
This subdirectory aims to provide all necessary files to complete milestone 1 for course NSWI130 teach at Charles University.

## Prerequisites
You have to have installed:
    - [docker](https://docs.docker.com/get-started/get-docker/)
    - [structurizr/lite](https://docs.structurizr.com/lite/quickstart)
to be able to visualize C4 model.

## Directory structure
The tasks for first milestone can be group into multiple parts:

1. C4 model

### C4 model
Files closely related to C4 model can be found in [C4_model subdirectory](./C4_model).
In root in contains the main workspace.dsl, from which you can visualize the C4 model.
Files for C3 layer are located [here](./C4_model/C3_layer).

### Display C4 model
To display C4 model run:
```bash
cd C4_model
docker run -it --rm -p 8080:8080 -v .:/usr/local/structurizr structurizr/lite
```

## Obsolated
Upozornění: nové responsibilities pro jednu feature ukládejte do samostatného souboru s danou feature, nikoli do souboru [Enrollments_feature_breakdown.md](Enrollments_feature_breakdown.md).

You will find list of all features [here](feature_breakdown.md).

You will find breakdown of all core features [here](Enrollments_feature_breakdown.md).
