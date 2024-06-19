cwlVersion: v1.2
$graph:
  - class: Workflow
    id: simple-runner-workflow5
    label: simple runner
    doc: simple runner
    requirements:
      NetworkAccess:
        networkAccess: true

    inputs:
      inputstring:
        type: string
        doc: the file to transform
    outputs:
      - id: asset-result
        type: Directory
        outputSource:
          - run-code/asset-result
    steps:
      run-code:
        run: "#code-runner"
        in:
          inputstring: inputstring
        out:
          - asset-result
  - class: CommandLineTool
    id: code-runner
    requirements:
        NetworkAccess:
            networkAccess: true
        DockerRequirement:
          dockerPull: public.ecr.aws/z0u8g6n1/simple_runner:0.2
    baseCommand: run_code.py
    inputs:
        inputstring:
            type: string
            inputBinding:
                prefix: --inputstring=
                separate: false
                position: 4
    outputs:
        asset-result:
          type: Directory
          outputBinding:
              glob: "./asset_output"