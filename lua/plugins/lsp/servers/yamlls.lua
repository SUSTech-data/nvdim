return {
    settings = {
        yaml = {
            schemas = {
                kubernetes = { "k8s**.yaml", "kube*/*.yaml" },
                ["https://kubernetesjsonschema.dev/v1.14.0/deployment-apps-v1.json"] = {
                    "k8s**.yaml",
                    "kube*/*.yaml",
                },
            },
        },
    },
}
