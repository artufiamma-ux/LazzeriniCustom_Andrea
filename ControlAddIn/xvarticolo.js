document.body.innerHTML = `
<div id="xv-articolo">

    <label>CODICE ARTICOLO</label>

    <input
        id="barcode"
        type="text"
        placeholder="Scansiona articolo..."
        autofocus
    />
<div id="card-result" id="card-result" >
<div><span id="row1">-</span></div>
<div><span id="row2">-</span></div>
<div><span id="row3">-</span></div>
<div><span id="row4">-</span></div>
</div>

    <button class="stampa" id="btn-stampa">
        🖨 STAMPA
    </button>

    <button class="cerca" id="btn-cerca">
        🔍 CERCA
    </button>


</div>
`;

function getBarcode() {
    return document.getElementById('barcode').value;
}

document.getElementById('btn-stampa')
    .addEventListener('click', function () {
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
            'ActionSelected',
            ['STAMPA', getBarcode()]
        );
    });

document.getElementById('btn-cerca')
    .addEventListener('click', function () {
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
            'ActionSelected',
            ['CERCA', getBarcode()]
        );
    });
document.getElementById('barcode')
    .addEventListener('change', function() {

    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
        'BarcodeScanned',
        [this.value]
    );
});
document.getElementById('barcode')
    .addEventListener('keydown', function(e) {

    if (e.key === 'Enter')
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
            'BarcodeScanned',
            [this.value]
        );
});
window.SetItemData = function(row1, row2, row3, row4) {

    document.getElementById('row1').innerText = row1;
    document.getElementById('row2').innerText = row2;
    document.getElementById('row3').innerText = row3;
    document.getElementById('row4').innerText = row4;
    document.getElementById('card-result').style.display = 'block';
};