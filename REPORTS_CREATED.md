# Report Created In This Workspace

This document summarizes the reports we created or adapted in this workspace, with the name used in the specifications, the AL object name, and the related extension or launch point.

## Summary Table

| Spec name | AL object name | Type | Related page / action | Notes |
|---|---|---|---|---|
| Prod. Order - Detailed Calc. | `XV Prod. Order Dtl Calc.` | `report 50301` | `Firm Planned Prod. Order` page extension action `StampaProdOrderDetailedCalc` | Standalone report with RDLC layout `ReportLayouts/XVProdOrderDetailedCalc.rdlc`. Uses barcode and production-order reference fields. |
| XV Ordine Conto Lavoro | `XV Ordine Conto Lavoro` | `report 50244` | Purchase / work-order print flow | Custom report for subcontracting / work-order printing. |
| XV Ordine Acquisto | `XV Ordine Acquisto` | `report 50245` | Purchase order print flow | Custom purchase-order report. |
| XV Ordine Acquisto Kit Bus | `XV Ordine Acquisto Kit Bus` | `report 50246` | Purchase order print flow | KitBus variant of the purchase-order report. |
| XV Etich. Ricambi Packing List | `XV Etich. Ricambi Packing List` | `report 50247` | Packing list print flow | Spare-parts packing-list label report. |

## Related Page Extensions

| Page extension | Extends | Purpose |
|---|---|---|
| `XV Released Prod. Order Ext` | `Firm Planned Prod. Order` | Adds the action that opens `XV Prod. Order Dtl Calc.` |

## Notes

- The production-order report is a standalone report object, not a `reportextension`.
- The barcode in `XV Prod. Order Dtl Calc.` follows the same barcode font style used in `XVEtichettaRicambiPackingList.rdl` (`IDAutomationHC39M`).
- If you want, this document can be expanded with a change log or with links to the exact files and line ranges.