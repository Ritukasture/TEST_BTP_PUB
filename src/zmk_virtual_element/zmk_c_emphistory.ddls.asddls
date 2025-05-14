@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZMK_C_EMPHISTORY
  provider contract transactional_query
  as projection on ZMK_I_EMPHISTORY
{
      @UI.facet: [{
        label: 'General Information',
        id: 'GeneralInfo',
        purpose: #STANDARD,
        position: 10,
        type: #IDENTIFICATION_REFERENCE
        }]
      @EndUserText.label: 'Name'
      @UI.identification: [{ position: 10 }]
      @UI.lineItem: [{ position: 10  }]
      @UI.selectionField: [{ position: 10 }]
  key Name,
      @EndUserText.label: 'Start Date'
      @UI.identification: [{ position: 20 }]
      @UI.lineItem: [{ position: 20  }]
      @UI.selectionField: [{ position: 20 }]
      Startdate,
      @EndUserText.label: 'End Date'
      @UI.identification: [{ position: 30 }]
      @UI.lineItem: [{ position: 30  }]
      @UI.selectionField: [{ position: 30 }]
      Enddate,
      @EndUserText.label: 'Total Days'
      @UI.identification: [{ position: 40 }]
      @UI.lineItem: [{ position: 40  }]
      @UI.selectionField: [{ position: 40 }]
      @ObjectModel: { virtualElementCalculatedBy: 'ABAP:ZCL_MK_CAL_DAYS' }
      numdays
}
