cwlVersion: v1.2
$namespaces:
  s: https://schema.org/
s:softwareVersion: 0.0.4
schemas:
  - http://schema.org/version/9.0/schemaorg-current-http.rdf
$graph:
  - class: Workflow
    id: simple-runner-workflow
    label: simple runner
    doc: simple runner
    requirements:
      NetworkAccess:
        networkAccess: true
      InlineJavascriptRequirement: {}

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
          dockerPull: public.ecr.aws/z0u8g6n1/simple_runner:latest
    baseCommand: run_code.py
    stdout: impact_stdout.txt
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