@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMK_C_EMPLOYEE
  provider contract transactional_query
  as projection on ZMK_I_EMPLOYEE
{
      @EndUserText.label: 'Employee Num'
      @UI.facet: [{
           label: 'General Information',
           id: 'GeneralInfo',
           purpose: #STANDARD,
           position: 10,
           type: #IDENTIFICATION_REFERENCE
           }]

      @UI.identification: [{ position: 10 }]
      @UI.lineItem: [{ position: 10  }]
      @UI.selectionField: [{ position: 10 }]
  key Num,
      @EndUserText.label: 'Name'
      @UI.identification: [{ position: 20 }]
      @UI.lineItem: [{ position: 20  }]
      @UI.selectionField: [{ position: 20 }]
  key Name,
      @EndUserText.label: 'Age'
      @UI.identification: [{ position: 30 }]
      @UI.lineItem: [{ position: 30  }]
      @UI.selectionField: [{ position: 30 }]
      Age
}
