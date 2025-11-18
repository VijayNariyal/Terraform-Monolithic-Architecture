output "resource_group" {
    description = "the output value of the resource group block"
    value = {
        for name, RG in azurerm_resource_group.RG :
        name => {
            id = RG.id
        }
    }
}