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
2. Features
3. Layer architecture draft
4. Docs

### C4 model
Files closely related to C4 model can be found in [C4_model subdirectory](./C4_model).
In root in contains the main workspace.dsl, from which you can visualize the C4 model.
Files for C3 layer are located [here](./C4_model/C3_layer).

### Features
Files related to features and responsibilities identification can be found in [Features subdirectory.](./Features)
The [feature_list.md](./Features/feature_list.md) identifies 8 feature with their motivation and their separation on core and auxiliary (with short reasoning).
The [Core_features](./Features/Core_features) contains for each core for feature detailed description file (coreX_breakdown.md for X feature). There are manually concatenate [here](./Features/Core_features/Enrollments_feature_breakdown.md). However this file is probably obsoleted (depends on manual synchronization with coreX_breakdown.md files).

### Layer architecture draft
[This subdirectory](./Layer_architecture_draft) visualize our understanding of our module before we learn about C4 module on lectures. So it may be obsoleted.

### Docs
Provide documentation for our module. Specifically [here](./Docs/context.md) is describe a user story for the module.

### Display C4 model
To display C4 model run:

```bash
cd C4_model
docker run -it --rm -p 8080:8080 -v .:/usr/local/structurizr structurizr/lite
```

## Obsoleted
Upozornění: nové responsibilities pro jednu feature ukládejte do samostatného souboru s danou feature, nikoli do souboru [Enrollments_feature_breakdown.md](Enrollments_feature_breakdown.md).

You will find list of all features [here](feature_breakdown.md).

You will find breakdown of all core features [here](Enrollments_feature_breakdown.md).
